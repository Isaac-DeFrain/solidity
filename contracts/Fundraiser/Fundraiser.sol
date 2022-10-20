// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Pledge.sol";
import "./Escrow.sol";

contract Fundraiser {
    using PledgeMap for PledgeMap.Pledge[];

    // -------------------
    // --- constructor ---
    // -------------------

    constructor(uint duration) {
        accAmt = 0;
        empties = new uint[](0);
        endBlock = block.number + duration;
        escrow = new Escrow(msg.sender, block.number + duration);
        owner = msg.sender;
    }

    // -----------------
    // --- variables ---
    // -----------------

    // private
    uint[] private empties;              // array of map indices which were removed

    // public
    uint public accAmt;                  // accumulated amount of pledged funds
    uint immutable public endBlock;      // number of the end block
    Escrow immutable public escrow;      // escrow account contract
    address immutable public owner;      // owner address
    PledgeMap.Pledge[] public pledgeMap; // map of pledges

    // -----------------
    // --- modifiers ---
    // -----------------

    modifier checkOwner {
        require(msg.sender == owner, "invalid owner");
        _;
    }

    modifier afterExpiry {
        require(block.number >= endBlock, "fundraiser is not over!");
        _;
    }

    modifier bailFee {
        require(msg.value > 1_000_000_000, "gotta pay to bail");
        _;
    }

    // -----------------
    // --- functions ---
    // -----------------

    function currBlock() external view returns (uint) {
        return block.number;
    }

    // sender pledges amount
    function pledge() public payable {

        uint amount = msg.value;
        require(amount > 1_000_000_000, "need a lil something");

        // transfer funds to escrow
        escrow.pledge(msg.sender, amount);

        accAmt += amount;
        PledgeMap.Pledge memory p = PledgeMap.Pledge({addr: msg.sender, amount: amount});
        // if successful, add pledge to pledgeMap
        // check empties + drop empties + add pledge
        if (empties.length != 0) {
            pledgeMap[empties[0]] = p;
            empties.pop();
        } else {
            // if no empty spots, push the pledge
            PledgeMap.push(pledgeMap, p);
        }
    }

    // sender revokes their most recent pledge
    function revokePledge() external payable bailFee {
        uint amount;
        bool found = false;
        for (uint i = pledgeMap.length; i > 0 ; i--) {
            uint _i = i - 1;
            // delete last pledge from sender
            if (pledgeMap[_i].addr == msg.sender) {
                found = true;
                amount = pledgeMap[_i].amount;
                pledgeMap[_i] = PledgeMap._default();
                empties.push(_i);
            }
            if (found) { break; }
        }
        if (amount > 0) {
            escrow.revoke(payable(msg.sender), amount);
        }
    }

    // check caller is owner and expiration
    // caller attempts to extract funds from the escrow contract
    function extractFunds() external afterExpiry checkOwner {
        escrow.extractFunds(payable(msg.sender));
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "extract funds failed");
    }

    // --------------------------
    // --- receive & fallback ---
    // --------------------------

    // no call data
    receive() external payable { pledge(); }

    // call data
    fallback() external payable { pledge(); }
}
