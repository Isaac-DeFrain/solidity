// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

// Fun specification
abstract contract FunSpec {
    function pubF(uint) public pure virtual returns (uint);
}

// Fun implementation
// function calls in solidity
contract Fun is FunSpec {
    
    // -----------------
    // --- Internals ---
    // -----------------
    
    // pure, recursive function which computes 1 + ... + x
    function f(uint x) internal pure returns (uint) {
        // gas cost: 45160
        if (x == 0) { return 0; } else { return x + f(x - 1); }
    }

    // pure function which computes x * (x + 1) / 2 instead
    function f2(uint x) internal pure returns (uint) {
        // gas cost: 23108
        return x * (x + 1) / 2;
    }

    // ------------------------
    // --- Public Interface ---
    // ------------------------

    // public function for users to call internal f
    function pubF(uint x) public pure override returns (uint) {
        return f(x);
    }

    // public function for users to call internal f2
    function pubF2(uint x) public pure returns (uint) {
        return f2(x);
    }
}

// modifier = { pre-condition; post-condition }

// playing with enums, structs, arrays, etc.
contract Types {

    enum Grade { A, B, C, D, F }
    enum Semester { Spring, Summer, Fall }
    enum Degree { BA, BS, MA, MS, PhD }

    struct Instructors { string[] names; }
    struct School { string name; }

    struct Class {
        uint id;
        uint year;
        string name;
        School school;
        Instructors instructs;
        Semester semester;
        Grade grade;
    }

    struct Student {
        bool degreeEarned;
        Degree degree;
        School school;
        Class[] classHistory;
    }

    // 
}
