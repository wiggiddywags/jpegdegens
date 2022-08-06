import "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";

describe("hello world", function() {
    it("should say hi", async function() {
        // 1. setup our environment
        // 2. deploy our contract
        // 3. call our functions to test

        // 2.
        // give it the name of the Contract (not the name of the file)
        const HelloWorld = await ethers.getContractFactory("HelloWorld");
        const hello = await HelloWorld.deploy(); //puts the contract on an Ethereum network
        await hello.deployed(); // confirms contract is on the network.

        expect(await hello.hello()).to.equal("Hello, World");
    });
})