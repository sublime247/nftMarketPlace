# NFT Marketplace Contract

## Overview
This Solidity contract is designed for a basic NFT marketplace, allowing users to **mint**, **create**, **buy**, and **sell** NFTs.

## Features
- **Minting**: The contract allows the owner to mint new NFTs with a specified token URI.
- **Creating**: Users can create new NFT items and list them for sale.
- **Buying**: Users can buy listed NFT items.
- **Ownership Management**: The contract keeps track of NFT ownership and ensures that only the owner can perform specific actions.

---

## Functions

### `mintNft`
- **Description**: Mints a new NFT with the specified token URI.
- **Parameters**: 
  - `tokenURI` (string) - The token URI for the new NFT.
- **Returns**: 
  - `uint256` - The ID of the newly minted NFT.
- **Modifiers**: 
  - `OnlyOwner` - Only the contract owner can call this function.

### `createItem`
- **Description**: Creates a new NFT item and lists it for sale.
- **Parameters**: 
  - `tokenId` (uint256) - The ID of the NFT to create.
  - `price` (uint256) - The price of the NFT.
- **Returns**: None.

### `buyItem`
- **Description**: Buys a listed NFT item.
- **Parameters**: 
  - `_nftId` (uint256) - The ID of the NFT to buy.
- **Returns**: None.
- **Modifiers**: 
  - `nonReentrant` - Prevents reentrancy attacks.

### `tokenURI`
- **Description**: Returns the token URI for a given NFT ID.
- **Parameters**: 
  - `tokenId` (uint256) - The ID of the NFT.
- **Returns**: 
  - `string memory` - The token URI for the NFT.

### `supportsInterface`
- **Description**: Checks if the contract supports a given interface.
- **Parameters**: 
  - `interfaceId` (bytes4) - The ID of the interface.
- **Returns**: 
  - `bool` - True if the contract supports the interface, false otherwise.

### `totalNft`
- **Description**: Returns the total number of sold NFTs.
- **Returns**: 
  - `uint256` - The total number of sold NFTs.

---

## Modifiers

### `OnlyOwner`
- **Description**: Checks if the caller is the contract owner.
- **Parameters**: None.
- **Returns**: None.

### `nonReentrant`
- **Description**: Prevents reentrancy attacks.
- **Parameters**: None.
- **Returns**: None.

---

## Contract Variables
- `tokenIds`: The current token ID.
- `owner`: The contract owner.
- `nftIds`: The current NFT ID.
- `soldNfts`: The total number of sold NFTs.
- `nftItems`: A mapping of NFT IDs to NFT items.
- `allNft`: An array of all NFT items.

---

## Structs

### `NFTItem`
- **Description**: Represents an NFT item.
- **Variables**:
  - `nftId`: The ID of the NFT.
  - `price`: The price of the NFT.
  - `owner`: The owner of the NFT.
  - `isSold`: Whether the NFT is sold.

---

## Security Considerations
- **Reentrancy**: The contract uses the `nonReentrant` modifier to prevent reentrancy attacks.
- **Ownership**: The contract ensures that only the owner can perform certain actions.

---

## Deployment
- **Network**: The contract can be deployed on any Ethereum-compatible network.
- **Gas**: The contract requires a sufficient amount of gas to execute its functions.

---

## Testing
- **Unit tests**: The contract should be tested using unit tests to ensure its functionality.
- **Integration tests**: The contract should be tested using integration tests to ensure its interaction with other contracts.

---

## License
**MIT**: The contract is licensed under the MIT license.
