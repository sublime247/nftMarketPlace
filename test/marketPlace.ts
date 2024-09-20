import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";

describe("NFTMarketPlace", function () {
  async function deployNFTMarketPlace() {
    const [owner, otherAccount, otherAccount1] = await hre.ethers.getSigners();
    const NFTMarketPlace = await hre.ethers.getContractFactory("NftMarketPlace");
    const nftMarketPlace = await NFTMarketPlace.deploy();
    return { nftMarketPlace, owner, otherAccount, otherAccount1 };
  
  }
  
  describe("Deployment", function () {
    it("Should set the right owner", async function () {
      const { nftMarketPlace, owner } = await loadFixture(deployNFTMarketPlace);
      expect(await nftMarketPlace.owner()).to.equal(owner.address);
    });

  });
  describe("Mint", function () {
    it("Should Check if owner can mint NFT", async function () {
      const { nftMarketPlace, owner, otherAccount } = await loadFixture(deployNFTMarketPlace);
      await nftMarketPlace.mintNft("https://");
      expect(await nftMarketPlace.connect(owner).ownerOf(1)).to.equal(owner.address);

    });
    it("Should Revert if otherAccount is trying to mint NFT", async function () {
      const { nftMarketPlace, owner, otherAccount } = await loadFixture(deployNFTMarketPlace);
      await expect( nftMarketPlace.connect(otherAccount).mintNft("https://")).to.be.revertedWith("You are not Authorize for this")

    });

  });
  describe("CreateItem", function () {
    it("Should Check if user can create an Item", async function () {
      const { nftMarketPlace, owner, otherAccount } = await loadFixture(deployNFTMarketPlace);
      const amt = hre.ethers.parseUnits("1", "ether");
  
      // First, the owner needs to mint the NFT
      await nftMarketPlace.connect(owner).mintNft("https://");
      await nftMarketPlace.connect(owner).mintNft("https://");
  
      // Now otherAccount can list the item for sale (assuming owner has transferred it)
      await nftMarketPlace.connect(owner).transferFrom(owner.address, otherAccount.address, 1);
  
      // Now otherAccount can create an item for sale
      await nftMarketPlace.connect(otherAccount).createItem(1, amt);
      // await nftMarketPlace.connect(otherAccount).createItem(1, amt);
      expect(await nftMarketPlace.connect(otherAccount).ownerOf(1)).to.equal(otherAccount.address);
      // expect(await nftMarketPlace.connect(otherAccount).ownerOf(1)).to.equal(otherAccount.address);
      const tx = await nftMarketPlace.nftItems(1);
       expect( tx.price).to.equal(amt);
      expect(tx.nftId).to.equal(1);
      expect(tx.owner).to.equal(otherAccount.address);
      expect(tx.isSold).to.equal(false);

    });
  });

  describe("BuyItem", function () {
    it("Should Check if user can buy an Item", async function () {
      const { nftMarketPlace, owner, otherAccount, otherAccount1 } = await loadFixture(deployNFTMarketPlace);
      const amt = hre.ethers.parseUnits("1", "ether");
  
      // First, the owner needs to mint the NFT
      await nftMarketPlace.connect(owner).mintNft("https://");
      
      // Transfer the NFT to otherAccount
      await nftMarketPlace.connect(owner).transferFrom(owner.address, otherAccount.address, 1);
  
      // Now otherAccount can list the item for sale
      await nftMarketPlace.connect(otherAccount).createItem(1, amt);
  
      // Now otherAccount1 can buy the item, ensure the correct amount (amt) is sent
      await nftMarketPlace.connect(otherAccount1).buyItem(1, { value: amt });
  
      // Check that ownership has transferred
      expect(await nftMarketPlace.connect(otherAccount1).ownerOf(1)).to.equal(otherAccount1.address);
  
      const tx = await nftMarketPlace.nftItems(1);
      expect(tx.price).to.equal(amt);
      expect(tx.nftId).to.equal(1);
      expect(tx.owner).to.equal(otherAccount1.address);
      expect(tx.isSold).to.equal(true);
    });
  });
  
  

});
