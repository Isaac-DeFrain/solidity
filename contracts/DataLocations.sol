// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DataLocations {
    struct MyStruct {
        uint num;
        string text;
    }

    mapping (address => MyStruct) public myStructs;

    // calldata saves gas
    function examples(uint[] calldata input) internal returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({num: 123, text: "foo"});

        // update dynamic data, on-chain
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "bar";

        // read-only data, off-chain
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.num = 456;

        return input;
    }

    function set(uint _num, string calldata _text) public {
        myStructs[msg.sender] = MyStruct({num: _num, text: _text});
    }
}
