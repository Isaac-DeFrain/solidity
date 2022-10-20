// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ModifiersA.sol";

contract B {
    constructor() {
        owner = msg.sender;
        a = new A(owner);
    }

    modifier onlyOwner {
        require(msg.sender == owner, "expected owner B");
        _;
    }

    A public a;
    address immutable public owner;

    // get public variables from A contract

    function aOwner() public view returns (address) {
        return a.owner();
    }

    function aLastSetterIsOwner() public view returns (address, bool) {
        return a.lastSetter();
    }

    function aVar() public view returns (uint) {
        return a.aVar();
    }

    function aCountAmtMap(address addr) public view returns (uint, uint) {
        return a.cam(addr);
    }

    // interact with contract A

    function aSetClose(uint value) public payable onlyOwner {
        (bool success, ) = payable(address(a)).call{value: value}("");
        require(success, "aSet transfer failed B");
    }

    function aSet(uint _a) public payable {
        require(_a != 42 || msg.sender == owner, "only owner can set 42, silly");
        if (msg.sender != owner && msg.value < 10 * 10 ** 18) {
            require(a.aVar() != 42, "non-owners can only set when aVar != 42");
        }
        a.proxySet(_a, msg.sender);
    }



    function aOnlyOwnerSet42() public onlyOwner {
        a.onlyOwnerSet42();
    }

    // update contract
    // function updateA(A newA) public onlyOwner {
    //     a = newA;
    // }
}
