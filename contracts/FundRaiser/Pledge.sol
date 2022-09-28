// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

library PledgeMap {

    // TODO aggregate multiple pledges from the same address?

    // Pledge struct
    struct Pledge {
        address addr;
        uint amount;
    }

    function _default() internal pure returns (Pledge memory) {
        return Pledge({addr: address(0), amount: 0});
    }

    function getIndex(mapping (address => uint[]) storage indexMap, address addr) internal view returns (uint) {
        return indexMap[addr][0];
    }

    function getIndices(mapping (address => uint[]) storage indexMap, address addr) internal view returns (uint[] memory) {
        return indexMap[addr];
    }

    // functions on Pledge[]

    function atIndex(Pledge[] memory pledges, uint i) internal pure returns (Pledge memory) {
        return pledges[i];
    }

    // -----------
    // --- sum ---
    // -----------

    function sum(Pledge[] storage pledges) internal view returns (uint) {
        uint acc = 0;
        for (uint i = 0; i < pledges.length; i++) {
            acc += pledges[i].amount;
        }
        return acc;
    }

    // ------------
    // --- push ---
    // ------------

    // push Pledge onto existing Pledge[]
    function push(Pledge[] storage pledges, Pledge memory pledge) internal {
        pledges.push(pledge);
    }

    // --------------
    // --- remove ---
    // --------------

    // remove Pledge from existing Pledge[]
    function remove(Pledge[] storage pledges, Pledge memory pledge, uint amount) internal returns (bool, uint) {
        bool success;
        uint res;
        for (uint i = 0; i < pledges.length; i++) {
            if (pledges[i].addr == pledge.addr && pledges[i].amount == amount) {
                // if addr and amount match, then remove
                pledges[i] = Pledge({addr: address(0), amount: 0});
                success = true;
                res = i;
            }
        }
        return (success, res);
    }
}
