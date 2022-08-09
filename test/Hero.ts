import "@nomiclabs/hardhat-ethers";

import { ethers } from "hardhat";
import { expect } from "chai";
import { create } from "domain";

describe("Hero", function() {
    async function createHero() {
        const Hero = await ethers.getContractFactory("TestHero");
        const hero = await Hero.deploy();
        await hero.deployed();

        return hero;
    }

    let hero;

    before(async function() {
        hero = await createHero();
    });

    it("should get a zero hero array.", async function() {
        expect(await hero.getHeroes()).to.deep.equal([]);
    });

    it("should fail at creating hero cause of payment", async function() {
        let e;

        try {
            // 0 == Mage
            await hero.createHero(0, {
                value: ethers.utils.parseEther("0.049999999")
            });
        } catch(err) {
            e = err;
        }

        expect(e.message.includes("Please send maor money")).to.equal(true);
    });

    it("should pass at creating a Mage with Magic", async function() {
        const hero = await createHero();

        // Mage
        await hero.setRandom(69);
        await hero.createHero(0, {
            value: ethers.utils.parseEther("0.05")
        });
        const h = (await hero.getHeroes())[0];

        // [S, H, D, I, M]
        // [S, H, D, I]
        // [S, I, D]
        expect(await hero.getMagic(h)).to.equal(16);
        expect(await hero.getHealth(h)).to.equal(2);
    });
});