// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Counter {
    uint counter;

    event CounterInc(uint counter);
    //event CounterInc(uint address indexed addr, uint counter);

    // state changing function / write state ($)
    function count() public {
        counter++;
        console.log("Counter is now", counter);
        emit CounterInc(counter);
        //emit CounterInc(msg.sender, counter);
    }

    // read state (free)
    function getCounter() public view returns (uint32) {
        return uint32(counter);
    }
}