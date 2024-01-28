// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {TokenFactory} from "../src/TokenFactory.sol";

contract TokenFactoryScript is Script {
    TokenFactory public tokenFactory;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        tokenFactory = new TokenFactory();
        vm.stopBroadcast();
    }
}
