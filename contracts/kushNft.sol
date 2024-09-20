// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.24;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract EventNFT is ERC721URIStorage {
     uint256 tokenIds;

    constructor() ERC721("EventNFT", "EVT") {}

    

    function mintNft(string memory tokenURI)
        public
        returns (uint256)
    {
        tokenIds++;

        uint256 newItemId = tokenIds;
        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}



