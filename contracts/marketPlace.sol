// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftMarketPlace is ERC721URIStorage ,  ReentrancyGuard{
 uint256 tokenIds;
 address public owner;

    struct NFTItem{
        uint256 nftId;
        // string nftUri;
        uint256 price;
        address owner;
        bool isSold;
    }

    uint256 public nftIds;
    uint256 public soldNfts;

    mapping(uint256=>NFTItem) public nftItems;
    NFTItem[] allNft;

constructor()ERC721("EventNFT", "EVT"){
     owner = msg.sender;
}


modifier OnlyOwner() {
    require(msg.sender==owner, "You are not Authorize for this");
    _;
    
}

/*-----------minting of Nft-----------*/
    function mintNft(string memory tokenURi)
        public
         OnlyOwner
        returns (uint256)
   {
        tokenIds++;

        uint256 newItemId = tokenIds;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURi);

        return newItemId;
    }




/*------------funtion to create/list nft----------*/

    function createItem(uint256 tokenId, uint256 price  ) public{
        require(ownerOf(tokenId)==msg.sender, "you are not the owner");
        uint256 _nftId = nftIds+1;
        NFTItem storage _nftItem = nftItems[_nftId];
        _nftItem.nftId = _nftId;
        // _nftItem.nftUri= nftUri;
        _nftItem.price = price;
        _nftItem.owner = msg.sender;
        _nftItem.isSold = false;

        nftIds+=1;

        allNft.push(_nftItem);

    }


    /*------------------buy Item----------------*/
    function buyItem(uint256 _nftId) external payable  nonReentrant{
         NFTItem storage _nftItem = nftItems[_nftId];
         require(!_nftItem.isSold, "Already Sold");
         require(msg.value>= _nftItem.price, "Insufficient Amount");
         _nftItem.isSold=true;

         soldNfts+=1;
         _transfer(_nftItem.owner, msg.sender, _nftId);
         

        (bool success,) = _nftItem.owner.call{value: _nftItem.price}("");
        require(success );
      // Update the item with the new owner
    _nftItem.owner = msg.sender;
}

       // Override tokenURI to be used for NFT metadata management
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    // Override for interface support
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


    function totalnft() public view returns(uint256) {
         return soldNfts;
    }


}
