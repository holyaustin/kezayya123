// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "hardhat/console.sol";

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract FileNFT is ERC721URIStorage, VRFConsumerBaseV2 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    Counters.Counter private  _itemsShared;

  VRFCoordinatorV2Interface COORDINATOR;
  uint64 s_subscriptionId;
  address vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;
  bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;
  uint32 callbackGasLimit = 100000;
  uint16 requestConfirmations = 3;
  uint32 numWords =  2;
  uint256[] public s_randomWords;
  uint256 public s_requestId;
  address s_owner;
    // address owner;
    uint private monthly_value;
    address private owner;

    mapping(address => bool) accounts;
    mapping(uint256 => StorageItem) private idToStorageItem;

    struct StorageItem {
      uint256 tokenId;
      address owner;
      address storageDrive;
      bool shared;
    }

    event StorageItemCreated (
      uint256 indexed tokenId,
      address owner,
      address storageDrive,
      bool shared
    );
    event SubscriptionMade (
        address account
    );
    event MonthlyPaymentMade (
        address account
    );

    constructor() ERC721("Kezayya", "KEZAYYA") {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    s_owner = msg.sender;
    s_subscriptionId = subscriptionId;
    owner = payable(msg.sender);
      monthly_value = 100000;
    }


     /* Mints a File*/
    function createFile(string memory tokenURI) public payable returns (uint) {
      _tokenIds.increment();
      uint256 newTokenId = _tokenIds.current();

      _mint(msg.sender, newTokenId);
      _setTokenURI(newTokenId, tokenURI);
      createStorageItem(newTokenId);
      return newTokenId;
    }

    function createStorageItem(
      uint256 tokenId
    ) private {
      idToStorageItem[tokenId] =  StorageItem(
        tokenId,
        msg.sender,
        address(this),
        false
      );

      _transfer(msg.sender, address(this), tokenId);
      emit StorageItemCreated(
        tokenId,
        msg.sender,
        address(this),
        false
      );
    }

    // Transfers ownership of the item, as well as funds between parties 
    function createFileShare(
      uint256 tokenId
      ) public payable {

      idToStorageItem[tokenId].shared = true;
      _itemsShared.increment();
    }
    
    /* Returns all files on drive */
    function fetchAllStorageItems() public view returns (StorageItem[] memory) {
      uint itemCount = _tokenIds.current();
      uint currentIndex = 0;

      StorageItem[] memory items = new StorageItem[](itemCount);
      for (uint i = 0; i < itemCount; i++) {
        if (idToStorageItem[i + 1].storageDrive == address(this)) {
          uint currentId = i + 1;
          StorageItem storage currentItem = idToStorageItem[currentId];
          items[currentIndex] = currentItem;
          currentIndex += 1;
        }
      }
      return items;
    }


    /* Returns only items that a user has created   */
    function fetchMyFiles() public view returns (StorageItem[]memory) {
      uint totalItemCount = _tokenIds.current();
      uint itemCount = 0;
      uint currentIndex = 0;

      for (uint i = 0; i < totalItemCount; i++) {
        if (idToStorageItem[i + 1].owner == msg.sender) {
          itemCount += 1;
        }
      }

      StorageItem[] memory items = new StorageItem[](itemCount);
      for (uint i = 0; i < totalItemCount; i++) {
        if (idToStorageItem[i + 1].owner == msg.sender) {
          uint currentId = i + 1;
          StorageItem storage currentItem = idToStorageItem[currentId];
          items[currentIndex] = currentItem;
          currentIndex += 1;
        }
      }
      return items;
    }

       function subscribe() external payable {
        require(!accounts[msg.sender], "Account already subscribed");
        // require(msg.value == monthly_value, "Wrong value.");

        accounts[msg.sender] = true;
        emit SubscriptionMade(msg.sender);
    }

    function payMonthlyValue() external payable {
        require(accounts[msg.sender], "Account not subscribed");
        require(msg.value == monthly_value, "Wrong value.");

        emit MonthlyPaymentMade(msg.sender);
    }

    function requestRandomWords() external onlyOwner {
    // Will revert if subscription is not set and funded.
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      numWords
    );
  }

  function fulfillRandomWords(
    uint256, /* requestId */
    uint256[] memory randomWords
  ) internal override {
    s_randomWords = randomWords;
  }

    function withdraw(uint value) external {
        require(msg.sender == owner, "Address is not the owner");
        require(value <= address(this).balance, "Value higher than balance.");

        (bool success, ) = owner.call{value: value}("");
        require(success, "There was an error!");
    }

}