// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {Token} from "../src/Token.sol";

contract TokenScript is Script {
    Token public token;
    string name = "Test Token";
    string symbol = "TTK";
    uint256 totalSupply = 1000;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        token = new Token(name, symbol, totalSupply);
        vm.stopBroadcast();
    }
}
