// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./SafeTransfer.sol";

abstract contract IFundMe {
    function fund() public payable virtual returns (address);
}

contract FundMe is IFundMe {
    
    // constructor
    constructor() payable {
        data.push(Data({sender: msg.sender, amount: msg.value}));
        purse = payable(address(this));
    }

    // modifiers

    // must send at least 1 ETH to this contract
    modifier minAmount {
        require(msg.value > 1e18, "Didn't send enough");
        _;
    }

    // types

    struct Data {
        address sender;
        uint amount;
    }

    // variables

    address payable public purse;
    Data[] public data;

    // events

    event Transfer(address payer, uint amount);
    event Receive(address payer, uint amount);
    event Fallback(address payer, uint amount);

    // functions

    function fund() public payable minAmount override returns (address) {
        emit Transfer(msg.sender, msg.value);
        data.push(Data({ sender: msg.sender, amount: msg.value }));
        (bool sent, ) = purse.call{value: msg.value}("");
        require(sent, "failed to send!");
        return msg.sender;
    }

    function balance() public view returns (uint) {
        return address(this).balance;
    }

    // no calldata
    receive() payable external {
        emit Receive(msg.sender, msg.value);
        (bool sent, ) = purse.call{value: msg.value}("");
        require(sent, "failed to send!");
    }

    // calldata
    fallback() payable external {
        emit Fallback(msg.sender, msg.value);
        (bool sent, ) = purse.call{value: msg.value}("");
        require(sent, "failed to send!");
    }
}
