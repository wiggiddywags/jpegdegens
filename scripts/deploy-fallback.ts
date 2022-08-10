import "@nomiclabs/hardhat-ethers";
import { ethers } from "hardhat";

async function deploy(name, ...args) {
    const Fallback = await ethers.getContractFactory(name);
    const fallback = await Fallback.deploy(...args); //builds up a JSON request to RPC to some network
    await fallback.deployed(); //when it's down, it will be considered deploy
    
    console.log(fallback.address);
    
    return fallback;
}

async function printStorage(contract, name, count) {

    //get storage at index i at this address
    for (let i = 0; i < count; ++i) {
        console.log(name, i, await
            ethers.provider.getStorageAt(contract.address, i));
    }
}

async function fallback() {
    const a = await deploy("A");
    const b = await deploy("B", a.address);
    //const f = await ethers.getContractAt("IFallback", fallback.address);
    //await f.count();

    await printStorage(b, "B", 3);

    await b.setB(0x45);
    console.log("--------------------------");
    await printStorage(b, "B", 3);

    // console.log("A", await a.getA());
    // console.log("B", await b.getB());
    // console.log("------------------");

    // await a.setA(42);
    // console.log("A", await a.getA());
    // console.log("B", await b.getB());
    // console.log("------------------");

    // await b.setB(60);
    // console.log("A", await a.getA());
    // console.log("B", await b.getB());
    // console.log("------------------");
}

fallback();

//deploy().then(fallback);

// class Foo {
//     private bar: number;
//     foo() { console.log("foo", this.bar) }
// }

// const foo = new Foo();
// foo.foo();
// foo.foo.call({
//     bar: 42
// })