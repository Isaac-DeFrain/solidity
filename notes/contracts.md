# Visibility and Getters

## State Variable Visibility

`public` - getters are automatically derived by the compiler

`internal` - can only be accessed from within the contract in which they are defined and in derived contracts

`private` - like internal but not visible in derived contracts

## Function Visibility

`external`

`public`

`internal`

`private`

# Structure of a Contract

Solidity contracts are similar to classes in OOP

Contracts can inherit from other contracts

Special contracts called *libraries* and *interfaces*

## State Variables

Variables whose values are permanently stored in contract storage

```solidity
// SPDX-License-Indentifier: GPL-3.0
pragma solidity >=0.4.0 <0.9.0;

contract SimpleStorage {
  uint storeData; // only one state variable
  // ...
}
```

## Functions

- `view`
  - cannot modify the state

- `pure`
  - cannot read from or modify the state
  - can be evaluated at compile time from only it's arguments

- `payable`

- TODO

## Function Modifiers

*Pre* and *post* conditions on function call

Declared with `modifier` keyword

## Events

- abstraction on top of the EVM's logging functionality
- applications can subscribe and listen to events through the RPC interface
- inheritable members of contracts
  - calling stores the arguments in the transaction's log

Example declaration

```solidity
// declare Receive event
event Receive(address _from, uint _amt);

// emit Receive event
function receiveFunds(uint amount) public payable {
    // ...
    emit Receive(msg.sender, amount);
    // ...
}
```

## Errors

```solidity
error InvalidCredentials
```

## Struct Types

```solidity
struct Student {
    address addr;
    string name;
    uint age;
}
```

## Enum Types

```solidity
enum Grade { A, B, C, D, F }
```
