// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*

Design
We want to be able to generate random Hereos.
The user gets to put in their class of hereo on generation
classes: Mage, Healer, Barbarian
Class will not influence stats created, therefore getting an epic hero will be hard.
I want to be paid... 0.05 eth per hero!
I should be able to get my heroes I have generated.
Heroes should be stored on the chain.
stats are strength, health, intellect, magic, dexterity
stats are randomly generated
A scale of 1 - 18
The stats are randomly picked and their amplitude is randomly determined according to the following:
Stat 1 can max at 18
Stat 2 can max at 17
Stat 3 can max at 16
...
You could imagine these being an NFT
They are non divisable

*/

contract Hero {
    enum Class { Mage, Healer, Barbarian }

    // address == person who called the func
    mapping(address => uint[]) addressToHeroes;

    // don't use this in a real NFT collection (bc miners can manipulate block difficulty, etc.)
    function generateRandom() public virtual view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    }

    function getHeroes() public view returns (uint[] memory) {
        return addressToHeroes[msg.sender];
    }

    // bit-shift of class, return strength
    function getStrength(uint hero) public pure returns (uint32) {
        return uint32((hero >> 2) & 0x1F);
    }

    // bit-shift off class and strength to get health
    function getHealth(uint hero) public pure returns (uint32) {
        return uint32((hero >> 7) & 0x1F);
    }

    // bit-shift off class, strength and health to get Dex
    function getDex(uint hero) public pure returns (uint32) {
        return uint32((hero >> 12) & 0x1F); 
    }
    // bit-shift off class, strength, health and dex to get Intellect
    function getIntellect(uint hero) public pure returns (uint32) {
        return uint32((hero >> 17) & 0x1F); 
    }

    // bit-shift off class, strength, health, dex and intellect to get magic
    function getMagic(uint hero) public pure returns (uint32) {
        return uint32((hero >> 22) & 0x1F); 
    }

    // payable: this func can accept money
    function createHero(Class class) public payable {
        require(msg.value >= 0.05 ether, "Please send maor money");
        // strength, dexterity, health, intellect, magic
        uint[] memory stats = new uint[](5);
        stats[0] = 2;
        stats[1] = 7;
        stats[2] = 12;
        stats[3] = 17;
        stats[4] = 22;

        uint len = 5;
        uint hero = uint(class); //class is a value of 0,1,2 (mage, healer, barbarian)

        do {
            uint pos = generateRandom() % len;
            uint value = generateRandom() % (13 + len) + 1; // 1 - 18

            hero |= value << stats[pos]; //shift bitwise over left shift (multipling)

            len--;
            stats[pos] = stats[len];
        } while (len > 0);

        addressToHeroes[msg.sender].push(hero);
    }
}