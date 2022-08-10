// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Storage.sol";

contract A {
    //uint a;
   AppStorage s;

    function setA(uint _a) public {
        s.a = _a;
    }

    function getA() public view returns (uint) {
        return s.a;
    }
}

contract B {
    //uint b;
    //uint8 c;
    //uint8 d;
    //address ContractA;
    AppStorage s;


    constructor(address _A) {
        s.ContractA = _A;
        s.b = 4;
        s.c = 0x45;
        s.d = 0xF5;
    }

    function setB(uint _b) public {
        s.b = _b;
        //A(ContractA).setA(_a + 1);
        // ContractA.delegatecall(
        //     abi.encodeWithSignature("setA(uint256)", _b + 1)
        // );
        (bool success, bytes memory bbb) = s.ContractA.delegatecall(
            abi.encodeWithSignature("setA(uint256)", _b + 1)
        );
    }

    function getB() public view returns (uint) {
        return s.b;
    }
}