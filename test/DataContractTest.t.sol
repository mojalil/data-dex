// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {DeployDataContract} from "../script/DeployDataContract.s.sol";
import {DataContract} from "../src/DataContract.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract DataContractTest is StdCheats, Test {
    DataContract public dataContract;

    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    uint256 public constant GAS_PRICE = 1;
    address public constant USER = address(1);

    // Mock metadata, Json string containing data set metadata (source, type, date, etc.)
    string public constant source = "https://www.kaggle.com/uciml/iris";
    string public constant dataType = "csv";
    string public constant date = "2021-08-18";
    string public constant description = "Iris dataset";
    string public metadata = string(
            abi.encodePacked(
                '{"source": "',
                source,
                '", "type": "',
                dataType,
                '", "date": "',
                date,
                '", "description": "',
                description,
                '"}'
            )
        );

    // Id of the data set that was listed
    uint256 public id = 0;

    function setUp() external {
        DeployDataContract deployDataContract = new DeployDataContract();
        dataContract = deployDataContract.run();
        vm.deal(USER, STARTING_USER_BALANCE);
    }

    modifier dataListed() {
        // Mock metadata, Json string containing data set metadata (source, type, date, etc.)
        vm.prank(USER);
        id = dataContract.listData(metadata, 1 ether);
        _;
    }

    function testDataContractCounterIsZero() external {
        uint256 counter = dataContract.getDataIdCounter();
        assertEq(counter, 0);
    }

    function testListData() external {
        // Mock metadata, Json string containing data set metadata (source, type, date, etc.)
        assertEq(dataContract.getDataIdCounter(), 0);
        id = dataContract.listData(metadata, 1 ether);
        assertEq(id, 1);
    }

    function testListDataHasCorrectOwner() public dataListed {
        // Mock metadata, Json string containing data set metadata (source, type, date, etc.)
        address owner = dataContract.getDataOwner(id);
        assertEq(owner, USER);
    }

    function testListDataHasCorrectMetadata() public dataListed {
        // Mock metadata, Json string containing data set metadata (source, type, date, etc.)
        assertEq(dataContract.getDataMetadata(id), metadata);
    }

    // TODO: testListDataWithInsufficientBalance.. add a function to the cheats contract to set the balance of a user to zero and then test that the listData function reverts
}
