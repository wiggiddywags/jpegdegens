//SPDX-License-Identifier: MIT
//tell compiler what to expect
pragma solidity ^0.8.0;

contract HelloWorld {
    function hello() public pure returns (string memory) {
        return "Hello, World";
    }
}
