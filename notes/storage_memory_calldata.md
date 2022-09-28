# Storage, Memory, and Calldata

`storage` - use to modify a state variable
`memory` - use to read/copy, but not modify
`calldata` - reference to call value

```solidity
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract DataLocations {
    struct MyStruct {
        uint num;
        string text;
    }

    mapping (address => MyStruct) public myStructs;

    // calldata saves gas
    function examples(uint[] calldata input) public returns (uint[] memory) {
        myStructs[msg.sender] = MyStruct({num: 123, text: "foo"});

        // update dynamic data, on-chain
        MyStruct storage myStruct = myStructs[msg.sender];
        myStruct.text = "bar";

        // read-only data, off-chain
        MyStruct memory readOnly = myStructs[msg.sender];
        readOnly.num = 456;

        return input;
    }
}

```
