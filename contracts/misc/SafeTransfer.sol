// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeTransfer {
    // check transfer succeeds, otherwise revert
    function transfer(address _to, uint _amount) public payable returns (bool) {
        (bool success, ) = payable(_to).call{value: _amount}("");
        return success;
    }
}
