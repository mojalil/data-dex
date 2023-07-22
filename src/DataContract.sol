// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

/**
 * @title A Blockchain-based Data Marketplace
 * @author motypes
 * @notice This contract is a work in progress and is not yet ready for production use
 * @dev Functions listData (allows sellers to list their data), 
 * buyData (allows buyers to purchase listed data), 
 * getOwner (returns the owner of a particular data set), 
 * transferOwnership (transfers ownership from seller to buyer).
 */

contract DataContract {

    // Type Declarations
    struct Data {
        address payable owner;
        string metadata; // Json string containing data set metadata (source, type, date, etc.)
        bool isVerfied; // Indicates whether the data set has been verified by the marketplace for accuracy
        uint256 price; // Price for which the data is listed
        bool isSold; // Indicates whether the data set has been sold
        bool isListed; // Indicates whether the data set is listed for sale

    }

    // State Variables
    mapping(uint256 => Data) public data; // Maps data set ID to data set




}