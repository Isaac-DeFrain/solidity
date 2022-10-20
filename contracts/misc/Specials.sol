// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Specials {
    // block
    function block_num() public view returns (uint) {
        return block.number;
    }

    // msg
    function msg_sender() public view returns (address) {
        return msg.sender;
    }    
}
