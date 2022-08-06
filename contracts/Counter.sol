pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Counter (
    uint counter;

    // state changing function
    function count() public returns (uint) {
        counter++;
        console.log("Counter is now", counter);
        return counter;
    }
)