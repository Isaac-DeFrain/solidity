// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Utils {
    function min(uint x, uint y) internal pure returns (uint) {
        if (x < y) { return x; } else { return y; }
    }
}
