import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function deploy() {
    const HelloWorld = await ethers.getContractFactory("HelloWorld");
    const hello = await HelloWorld.deploy(); //builds up a JSON request to RPC to some network
    await hello.deployed(); //when it's down, it will be considered deploy

    return hello;
}

// @ts-ignore
async function sayHello(hello) {
    console.log("Say Hello:", await hello.hello());
}

deploy().then(sayHello);