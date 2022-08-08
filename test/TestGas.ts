import "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";

describe("TestGas", function() {
    it("Test", async function() {

        const Gas = await ethers.getContractFactory("TestGas");
        const gas = await Gas.deploy(); //puts the contract on an Ethereum network
        await gas.deployed(); // confirms contract is on the network.

        for (let i = 0; i < 10; ++i) {
            await gas.test1();
            await gas.test2();
            await gas.test3();
            await gas.test4();
            await gas.test5();
        }
    });
})