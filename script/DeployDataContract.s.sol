// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DataContract} from "../src/DataContract.sol";

/**
 * @title DeployDataContract
 * @dev Deploys DataContract
 */

contract DeployDataContract is Script {
    function run() external returns (DataContract) {
        vm.startBroadcast();
        DataContract dataContract = new DataContract();
        vm.stopBroadcast();
        return dataContract;
    }
}
