// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ModifiersUtils.sol";

contract A {
    using Utils for uint;

    constructor(address addr) {
        owner = addr;
        creator = msg.sender;
    }

    // only creator can call
    modifier onlyCreator {
        require(msg.sender == creator, "expected creator");
        _;
    }

    // either owner or creator can call
    modifier eitherOwnerCreator {
        require(
            msg.sender == owner || msg.sender == creator,
            "caller must be creator or owner"
        );
        _;
    }

    address immutable public owner;   // owner of creator contract
    address immutable public creator; // creator contract address
    uint public aVar;

    struct AddrBool {
        address addr;
        bool isOwner;
    }
    AddrBool public lastSetter;

    struct CountAmt {
        uint amt;
        uint count; 
    }
    mapping(address => CountAmt) internal countAmtMap;

    // only owner can set == 42
    function onlyOwnerSet42() public eitherOwnerCreator {
        aVar = 42;
        lastSetter = AddrBool({addr: owner, isOwner: true});
        countAmtMap[owner].count += 1;
    }

    // set from proxy creator contract
    function proxySet(uint a, address addr) public payable onlyCreator {
        aVar = a;
        lastSetter = AddrBool({addr: addr, isOwner: addr == owner});
        countAmtMap[addr].amt += msg.value;
        countAmtMap[addr].count += 1;
    }

    // transfer _amt.min(bal) to owner
    function ownerWithdraw(uint _amt) public payable eitherOwnerCreator {
        uint bal = address(this).balance;
        (bool success, ) = payable(owner).call{value: _amt.min(bal)}("");
        require(success, "withdraw failed");
    }

    // return (count, amt)
    function cam(address _addr) public view returns (uint, uint) {
        CountAmt memory ca = countAmtMap[_addr];
        return (ca.count, ca.amt);
    }
}
