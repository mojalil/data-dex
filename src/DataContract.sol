// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

// Errors
error DataContract__DataNotOwnedBySeller();
error DataContract__DataAlreadyListed();
error DataContract__DataNotListed();
error DataContract__PriceNotMet();
error DataContract__DataIsAlreadySold();
error DataContract__NotVerifier();
error DataContract__NotOwner();
error DataContract__SellersCannotBeVerifiers();

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
        uint256 id; // Unique ID of the data set
        address payable owner; // Owner of the data set
        string metadata; // Json string containing data set metadata (source, type, date, etc.)
        uint256 price; // Price for which the data is listed
        bool isVerfied; // Indicates whether the data set has been verified by the marketplace for accuracy
        bool isSold; // Indicates whether the data set has been sold
        bool isListed; // Indicates whether the data set is listed for sale
    }

    // State Variables
    uint256 private i_dataIdCounter; // Counter for data sets
    address private i_owner; // Owner of the contract
    mapping(uint256 => Data) private s_dataStore; // Maps data set ID to data set
    mapping(address => bool) public verifiers; // Maps verifier address to verification status

    // Events

    // Emitted when a data set is listed
    event DataListed(
        uint256 indexed _id,
        address indexed _owner,
        string _metadata,
        uint256 _price
    );

    // Emitted when a data set is unlisted
    event DataUnlisted(
        uint256 indexed _id,
        address indexed _owner,
        string _metadata,
        uint256 _price
    );

    // Emitted when a data set is purchased
    event DataPurchased(
        uint256 indexed _id,
        address indexed _owner,
        string _metadata,
        uint256 _price
    );

    // Emitted when a data set is verified
    event DataVerified(uint256 indexed dataId, address indexed verifier);

    // Modifiers

    /**
     * @notice Check to see if the caller is the owner of the contract
     * @dev Throws an error if the caller is not the owner of the contract
     */

    modifier onlyOwner() {
        if (msg.sender != i_owner) {
            revert DataContract__NotOwner();
        }
        _;
    }

    /**
     * @notice Checks to see if the caller is a verifier
     */
    modifier onlyVerifiers() {
        if (verifiers[msg.sender] == false) {
            revert DataContract__NotVerifier();
        }
        _;
    }

    // Functions
    /**
     * 1. Constructor
     * 2. listData
     * 3. unListData
     * 4. reListData
     * 5. buyData
     * 7. verifyData
     * 8. Getters
     */

    constructor() {
        i_dataIdCounter = 0;
        i_owner = msg.sender;
    }

    /**
     * @notice Allows sellers to list their data
     * @dev Adds a new data set to the data store
     * @param _metadata Json string containing data set metadata (source, type, date, etc.)
     * @param _price Price for which the data is listed
     */
    function listData(
        string memory _metadata,
        uint256 _price
    ) external returns (uint256) {
        i_dataIdCounter++;
        s_dataStore[i_dataIdCounter] = Data(
            i_dataIdCounter,
            payable(msg.sender),
            _metadata,
            _price,
            false,
            false,
            true
        );
        emit DataListed(i_dataIdCounter, msg.sender, _metadata, _price);
        return i_dataIdCounter;
    }

    /**
     * @notice Allows sellers to unlist their data
     * @dev Removes a data set from the data store
     * @param _id ID of the data set
     */

    function unListData(uint256 _id) external {
        if (msg.sender != s_dataStore[_id].owner) {
            revert DataContract__DataNotOwnedBySeller();
        }

        if (s_dataStore[_id].isListed == false) {
            revert DataContract__DataNotListed();
        }
        s_dataStore[_id].isListed = false;

        emit DataUnlisted(
            _id,
            s_dataStore[_id].owner,
            s_dataStore[_id].metadata,
            s_dataStore[_id].price
        );
    }

    /**
     * @notice Allows sellers to relist their data
     * @dev Adds a data set back to the data store
     * @param _id ID of the data set
     */

    function reListData(uint256 _id) external {
        if (msg.sender != s_dataStore[_id].owner) {
            revert DataContract__DataNotOwnedBySeller();
        }

        if (s_dataStore[_id].isListed == true) {
            revert DataContract__DataAlreadyListed();
        }
        s_dataStore[_id].isListed = true;

        emit DataListed(
            _id,
            s_dataStore[_id].owner,
            s_dataStore[_id].metadata,
            s_dataStore[_id].price
        );
    }

    /**
     * @notice Allows buyers to purchase listed data
     * @dev Transfers ownership of a data set from seller to buyer
     * @param _id ID of the data set
     */

    function buyData(uint256 _id) external payable {
        // Check to see if the buyer has paid enough
        if (msg.value != s_dataStore[_id].price) {
            revert DataContract__PriceNotMet();
        }

        // Check to see if the data set is listed
        if (s_dataStore[_id].isListed == false) {
            revert DataContract__DataNotListed();
        }

        // Check to see if the data set has been sold
        if (s_dataStore[_id].isSold == true) {
            revert DataContract__DataIsAlreadySold();
        }

        s_dataStore[_id].owner.transfer(msg.value);
        s_dataStore[_id].isSold = true;
        s_dataStore[_id].isListed = false;

        emit DataPurchased(
            _id,
            s_dataStore[_id].owner,
            s_dataStore[_id].metadata,
            s_dataStore[_id].price
        );
    }

    /**
     * @notice Allows owner to set verfiers
     */

    function setVerifier( address verifier,bool _isVerifier ) external onlyOwner {
        verifiers[verifier] = _isVerifier;
    }

    /**
     * @notice Allows verifiers to verify data
     * @dev Verifies a data set
     * @param _id ID of the data set
     */

    function verifyData(uint256 _id) external onlyVerifiers {
        // Sellers cannot be verifiers, this would be a conflict of interest
        if (msg.sender == s_dataStore[_id].owner) {
            revert DataContract__SellersCannotBeVerifiers();
        }

        // Check to see if the data set is listed
        if (s_dataStore[_id].isListed == false) {
            revert DataContract__DataNotListed();
        }

        s_dataStore[_id].isVerfied = true;
        emit DataVerified(_id, msg.sender);
    }

    // Getters

    /**
     * @notice Get current data ID counter
     * @return uint256 Current data ID counter
     */

    function getDataIdCounter() external view returns (uint256) {
        return i_dataIdCounter;
    }

    /**
     * @notice Returns the owner of a particular data set
     * @param _id ID of the data set
     * @return address Owner of the data set
     */

    function getDataOwner(uint256 _id) external view returns (address) {
        return s_dataStore[_id].owner;
    }

    /**
     * @notice Get data set price
     * @param _id ID of the data set
     * @return uint256 Price for which the data is listed
     */
    function getDataPrice(uint256 _id) external view returns (uint256) {
        return s_dataStore[_id].price;
    }

    /**
     * @notice Get data set verification status
     * @param _id ID of the data set
     * @return bool Indicates whether the data set has been verified by the marketplace for accuracy
     */

    function getDataVerificationStatus(
        uint256 _id
    ) external view returns (bool) {
        return s_dataStore[_id].isVerfied;
    }

    /**
     * @notice Get data set sold status
     * @param _id ID of the data set
     * @return bool Indicates whether the data set has been sold
     */

    function getDataSoldStatus(uint256 _id) external view returns (bool) {
        return s_dataStore[_id].isSold;
    }

    /**
     * @notice Get data set listed status
     * @param _id ID of the data set
     * @return bool Indicates whether the data set is listed for sale
     */

    function getDataListedStatus(uint256 _id) external view returns (bool) {
        return s_dataStore[_id].isListed;
    }

    /**
     * @notice Get data set metadata
     * @param _id ID of the data set
     * @return string Json string containing data set metadata (source, type, date, etc.)
     */

    function getDataMetadata(
        uint256 _id
    ) external view returns (string memory) {
        return s_dataStore[_id].metadata;
    }

    /**
     * @notice Returns a data set
     * @param _id ID of the data set
     * @return uint256 ID of the data set
     * @return address Owner of the data set
     * @return string Json string containing data set metadata (source, type, date, etc.)
     * @return uint256 Price for which the data is listed
     * @return bool Indicates whether the data set has been verified by the marketplace for accuracy
     * @return bool Indicates whether the data set has been sold
     * @return bool Indicates whether the data set is listed for sale
     */

    function getDataSet(
        uint256 _id
    )
        external
        view
        returns (uint256, address, string memory, uint256, bool, bool, bool)
    {
        return (
            s_dataStore[_id].id,
            s_dataStore[_id].owner,
            s_dataStore[_id].metadata,
            s_dataStore[_id].price,
            s_dataStore[_id].isVerfied,
            s_dataStore[_id].isSold,
            s_dataStore[_id].isListed
        );
    }
}
