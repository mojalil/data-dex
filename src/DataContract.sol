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
        uint256 id;
        address payable owner;
        string metadata; // Json string containing data set metadata (source, type, date, etc.)
        uint256 price; // Price for which the data is listed
        bool isVerfied; // Indicates whether the data set has been verified by the marketplace for accuracy
        bool isSold; // Indicates whether the data set has been sold
        bool isListed; // Indicates whether the data set is listed for sale

    }

    // State Variables
    uint256 private i_dataIdCounter; // Counter for data sets
    mapping(uint256 => Data) private s_dataStore; // Maps data set ID to data set

    // Events
    event DataListed(uint256 indexed _id, address indexed _owner, string _metadata, uint256 _price);

    // Functions
    /**
     * 1. Constructor
     * 2. listData
     * 3. unListData
     * 4. reListData
     * 5. buyData
     * 7. verifyData
     * 8. getOwner
     * 9. getDataSet
     */
    
    constructor() {
        i_dataIdCounter = 0;
    }

    /**
     * @notice Allows sellers to list their data
     * @dev Adds a new data set to the data store
     * @param _metadata Json string containing data set metadata (source, type, date, etc.)
     * @param _price Price for which the data is listed
     */
    function listData(string memory _metadata, uint256 _price) external returns (uint256) {
        i_dataIdCounter++;
        s_dataStore[i_dataIdCounter] = Data(i_dataIdCounter, payable(msg.sender), _metadata, _price, false, false, true);
        emit DataListed(i_dataIdCounter, msg.sender, _metadata, _price);
        return i_dataIdCounter;
    }

}