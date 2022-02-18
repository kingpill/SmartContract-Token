const { expect } = require("chai");
const { ethers } = require("hardhat");


describe('Token Contract', ()=>{
	let Token, token, owner, address1, address2;
	beforeEach(async() =>{
		Token = await ethers.getContractFactory('Token');
		token = await Token.deploy();
		[owner, address1, address2, __] = await ethers.getSigners();
	});
	describe('Deployment', ()=>{
		it('Should set the right owner', async()=>{
			expect(await token.owner()).to.equal(owner.address);
		});
		it('Should assign the total supply of tokens to the owner', async()=>{
			const ownerBalance = await token.balanceOf(owner.address);
			expect(await token.totalSupply()).to.equal(ownerBalance);
		});
	});
	
	describe('Transactions', ()=>{
		it('Should transfer tokens between accounts', async()=>{
			await token.transfer(address1.address, 50);
			const address1Balance = await token.balanceOf(address1.address);
			expect(address1Balance).to.equal(50);
			
			await token.connect(address1).transfer(address2.address, 50);
			const address2Balance = await token.balanceOf(address2.address);
			expect(address2Balance).to.equal(50);
		});
		it('Should fail if sender does not have enough tokens', async()=>{
			const initialOwnerBalance = await token.balanceOf(owner.address);
			await expect(
				token
					.connect(address1)
					.transfer(owner.address, 1)
			)
				.to
				.be
				.revertedWith('Not enough tokens');
			
			expect(
				await token.balanceOf(owner.address)
			)
				.to
				.equal(initialOwnerBalance);
		});
		
		it("Should update ba;ances after transfers", async ()=>{
			const initialOwnerBalance = await token.balanceOf(owner.address);
			
			await token.transfer(address1.address, 100);
			await token.transfer(address2.address, 50);
			
			const finalOwnerBalance = await token.balanceOf(owner.address);
			expect(finalOwnerBalance).to.equal(initialOwnerBalance - 150);
			
			const address1Balance = await token.balanceOf(address1);
			expect(address1Balance).to.equal(100);
			
			const address2Balance = await token.balanceOf(address2);
			expect(address2Balance).to.equal(50);
		});
	});
});
