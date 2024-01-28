// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token public token;

    error InsufficientBalance();

    string name = "Test Token";
    string symbol = "TTK";
    uint256 totalSupply = 1000;

    function setUp() public {
        token = new Token(name, symbol, totalSupply);
    }

    /////////////////////////////
    ///// VARIABLE DEPLOYED /////
    /////////////////////////////
    function test_deployedTokenContract() public {
        uint256 ownerBalance = token.balances(address(this));

        assertEq(token.name(), name);
        assertEq(token.symbol(), symbol);
        assertEq(token.totalSupply(), totalSupply * (10 ** 18));
        assertEq(ownerBalance, totalSupply * (10 ** 18));
    }

    /////////////////////////
    ///// FUNCTION TEST /////
    /////////////////////////
    function test_transferToken() public {
        address alex = address(0x123);
        uint256 initialOwnerBalance = token.balances(address(this));
        uint256 initialTargetBalance = token.balances(alex);

        token.transfer(alex, 1000);

        uint256 afterOwnerBalance = token.balances(address(this));
        uint256 afterTargetBalance = token.balances(alex);

        assertEq(initialOwnerBalance, totalSupply * (10 ** 18));
        assertEq(initialTargetBalance, 0);
        assertEq(afterOwnerBalance, initialOwnerBalance - 1000);
        assertEq(afterTargetBalance, initialTargetBalance + 1000);
    }

    /////////////////////
    ///// ERRO TEST /////
    /////////////////////
    function test_errorInsufficientBalance() public {
        address bob = address(0x2);

        vm.startPrank(address(0x1));
        vm.expectRevert(Token.InsufficientBalance.selector);
        token.transfer(bob, 1000);
        vm.stopPrank();
    }
}
