# Intro to Solidity

- [Remix IDE](https://remix.ethereum.org)
- [Solidity Docs](https://docs.soliditylang.org)
- [Solidity by Example](https://solidity-by-example.org/)
- [Chainlink](https://docs.chain.link/ethereum/)
- Videos
  - [Free Code Camp](https://www.youtube.com/watch?v=gyMwXuJrbJQ)
  - [Chainlink](https://www.youtube.com/c/chainlink/videos)
  - [Solidity by Example](https://www.youtube.com/playlist?list=PLO5VPQH6OWdVQwpQfw9rZ67O6Pjfo6q-p)

## Anatomy of a contract

- [License](intro.md#license)
- [Pragma](intro.md#pragma)
- [Contract](intro.md#contract)
  - [State Variables](intro.md#state-variables)
  - [Modifiers](intro.md#modifiers)
  - [Functions](intro.md#functions)
- [Library](intro.md#library)

### License

An `SPDX-License-Indetifier` comment is required at the top of every `.sol` file

For example

```solidity
// SPDX-License-Indetifier: MIT
```

### Pragma

Declare acceptable compiler versions

Examples

```solidity
pragma solidity ^0.8.7;
```

```solidity
pragma solidity >=0.7.2 <0.9.0;
```

### Contract

- *concrete* contracts
- abstract contracts
  - interface

#### Constructor

The *constructor* called once contract is created, before it's deployed

#### State Variables

mutable variables whose values are maintained on the blockchain

#### Modifiers

*pre* and *post* conditions for functions

- *pre* condition

```solidity
modifier onlyOwner {
    require(msg.sender == owner);
    _;
}
```

- *post* condition

```solidity
modifier onlyOwner {
    _;
    require(msg.sender.balance >= 0);
}
```

#### Functions

callable functions

### Library

no state variables

all functions are `internal`
