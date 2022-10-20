// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Escrow {

    // -------------------
    // --- constructor ---
    // -------------------

    constructor(address bene, uint end_block) {
        addr = address(this);
        beneficiary = bene;
        creator = msg.sender;
        endBlock = end_block;
    }

    // -----------------
    // --- variables ---
    // -----------------

    uint public balance;                  // contract balance
    uint immutable public endBlock;       // expiration block number
    address immutable public creator;     // creator address
    address immutable public addr;        // payable address of this contract
    address immutable public beneficiary; // payable beneficiary address

    mapping(address => uint) public pledgeMap;

    // -----------------
    // --- modifiers ---
    // -----------------

    modifier beforeExpiry {
        require(block.number < endBlock, "fundraiser is over!");
        _;
    }

    modifier afterExpiry {
        require(block.number >= endBlock, "fundraiser is not over!");
        _;
    }

    modifier onlyCreator {
        require(msg.sender == creator, "only creator can call this function");
        _;
    }

    // -----------------
    // --- functions ---
    // -----------------

    // add pledge to total + addr
    function pledge(address _addr, uint _amt) public payable beforeExpiry onlyCreator {
        balance += _amt;
        pledgeMap[_addr] += _amt;
    }

    // revoke a pledge
    function revoke(address _to, uint _amt) public payable beforeExpiry onlyCreator {
        require(address(this).balance >= _amt);
        (bool success, ) = payable(_to).call{value: _amt}("");
        require(success, "escrow revoke failed");
        balance -= _amt;
    }

    // extract funds
    function extractFunds(address a) public payable afterExpiry onlyCreator {
        require(a == beneficiary, "caller is not the beneficiary!");
        (bool success, ) = payable(beneficiary).call{value: balance}("");
        require(success, "escrow extractFunds failed!");
        balance = 0;
    }

    // --------------------------
    // --- receive & fallback ---
    // --------------------------

    // no call data
    receive() external payable {
        pledge(msg.sender, msg.value);
    }

    // call data
    fallback() external payable {
        pledge(msg.sender, msg.value);
    }
}
