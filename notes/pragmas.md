# Pragmas

Enables certain compiler features or checks

A `pragma` directive is *always* local to the source file

## Version Pragma

Restrict compilation to specified versions of the compiler

`pragma solidity ^0.8.17;`

- the `^` makes it so that the source code will compile with all compiler versions between `0.8.17` (*inclusive*) and `0.9.0` (*exclusive*)

## ABI Coder Pragma

- supports encoding and decoding of arbitrarily nested arrays and structs
- more extensive validation and safety checks
- potentially higher gas costs
- heightened security

## Experimental Pragmas

### ABI2

TODO

### SMTChecker

TODO
