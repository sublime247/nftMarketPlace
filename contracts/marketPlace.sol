// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NftMarketPlace is ReentrancyGuard{


    struct NFTItem{
        uint256 nftId;
        string nftUri;
        uint256 price;
        address owner;
        bool isSold;
    }

    uint256 public nftIds;
    uint256 public soldNfts;

    mapping(uint256=>NFTItem) nftItems;
    NFTItem[] allNft;


    /*------------funtion to create/list nft----------*/


    function createItem(string memory nftUri, uint256 price  ) private {
        uint256 _nftId = nftIds+1;
        NFTItem storage _nftItem = nftItems[_nftId];
        _nftItem.nftId = _nftId;
        _nftItem.nftUri= nftUri;
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
         
        (bool success,) = _nftItem.owner.call{value: _nftItem.price}("");
        require(success );
    } 

}