## NFT Marketplace
An NFT (Non-Fungible Token) Marketplace built on the Ethereum blockchain using Solidity and Hardhat. This project enables users to mint, list, and buy NFTs, with ownership of each NFT managed via the ERC-721 standard. It includes various smart contracts for NFT functionality and marketplace operations, allowing for secure trading of NFTs on the Ethereum network.


-Features
  -Minting NFTs: Only authorized users (contract owner) can mint new NFTs with associated metadata URIs.
  -Listing NFTs for Sale: NFT owners can list their tokens for sale by specifying a price.
  -Buying NFTs: Buyers can purchase NFTs by sending the required Ether to the marketplace contract.
  -Ownership Transfers: Upon a successful purchase, ownership of the NFT is transferred from the seller to the buyer.
  -Security: The contract uses the ReentrancyGuard modifier to prevent reentrancy attacks during transactions.