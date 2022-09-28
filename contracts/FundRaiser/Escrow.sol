// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Escrow {

    // -------------------
    // --- constructor ---
    // -------------------

    constructor(address b, uint n) {
        addr = payable(address(this));
        beneficiary = payable(b);
        endBlock = n;
    }

    // -----------------
    // --- variables ---
    // -----------------

    uint public balance;                // total amount of funds pledged (in Wei)
    uint public endBlock;               // expiration block number
    address payable public addr;        // payable address of this contract
    address payable public beneficiary; // payable beneficiary address

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

    // -----------------
    // --- functions ---
    // -----------------

    // add pledge to total + addr
    function pledge(uint amount) public payable {
        (bool success, ) = addr.call{value: amount}(""); // send from tx.origin to addr
        require(success, "escrow pledge failed!");
        balance += amount;
    }

    // revoke a pledge
    function revoke(address payable _to, uint _amount) public payable beforeExpiry {
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "escrow revoke failed");
        balance -= _amount;
    }

    // extract funds
    function extractFunds(address payable a) public payable afterExpiry {
        require(a == beneficiary, "caller is not the beneficiary!");
        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "escrow extractFunds failed!");
        balance = 0;
    }

    // no call data
    receive() external payable {
        pledge(msg.value);
    }

    // call data
    fallback() external payable {
        pledge(msg.value);
    }
}
