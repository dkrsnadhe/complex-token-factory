// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {TokenFactory} from "../src/TokenFactory.sol";

contract TokenFactoryTest is Test {
    TokenFactory public tokenFactory;

    function setUp() public {
        tokenFactory = new TokenFactory();
    }

    ///////////////////////////
    //// DEPLOYED CONTRACT ////
    ///////////////////////////
    function test_deployedContract() public {
        assertEq(tokenFactory.tokenId(), 1);
    }

    ///////////////////////
    //// FUNCTION TEST ////
    ///////////////////////
    function test_createToken() public {
        string memory name = "Test Token";
        string memory symbol = "TTK";
        uint256 totalSupply = 1000;

        tokenFactory.createToken(
            name,
            symbol,
            totalSupply,
            TokenFactory.TokenType(0)
        );

        (uint256 _tokenId, , address _tokenAddress) = tokenFactory
            .deployedTokens(1);

        (
            string memory _name,
            string memory _symbol,
            uint256 _totalSupply
        ) = tokenFactory.getTokenData(_tokenAddress);

        assertEq(tokenFactory.tokenId(), 2);
        assertEq(_tokenId, 1);
        assertEq(_name, name);
        assertEq(_symbol, symbol);
        assertEq(_totalSupply, totalSupply * (10 ** 18));
    }

    function test_transferToken() public {
        address alex = address(0x123);

        string memory name = "Test Token";
        string memory symbol = "TTK";
        uint256 totalSupply = 1000;

        tokenFactory.createToken(
            name,
            symbol,
            totalSupply,
            TokenFactory.TokenType(1)
        );

        (, , address _tokenAddress) = tokenFactory.deployedTokens(1);

        uint256 initialOwnerBalance = tokenFactory.getBalance(
            _tokenAddress,
            address(tokenFactory)
        );
        uint256 initialTargetBalance = tokenFactory.getBalance(
            _tokenAddress,
            alex
        );

        vm.startPrank(address(tokenFactory));
        tokenFactory.transferToken(_tokenAddress, alex, 1000);

        uint256 afterOwnerBalance = tokenFactory.getBalance(
            _tokenAddress,
            address(tokenFactory)
        );
        uint256 afterTargetBalance = tokenFactory.getBalance(
            _tokenAddress,
            alex
        );
        vm.stopPrank();

        assertEq(initialOwnerBalance, totalSupply * (10 ** 18));
        assertEq(initialTargetBalance, 0);
        assertEq(afterOwnerBalance, initialOwnerBalance - 1000);
        assertEq(afterTargetBalance, initialTargetBalance + 1000);
    }

    function test_getBalance() public {
        string memory name = "Test Token";
        string memory symbol = "TTK";
        uint256 totalSupply = 1000;

        tokenFactory.createToken(
            name,
            symbol,
            totalSupply,
            TokenFactory.TokenType(1)
        );

        (, , address _tokenAddress) = tokenFactory.deployedTokens(1);

        uint256 balance = tokenFactory.getBalance(
            _tokenAddress,
            address(tokenFactory)
        );

        assertEq(balance, totalSupply * (10 ** 18));
    }

    function test_getTokenData() public {
        string memory name = "Test Token";
        string memory symbol = "TTK";
        uint256 totalSupply = 1000;

        tokenFactory.createToken(
            name,
            symbol,
            totalSupply,
            TokenFactory.TokenType(1)
        );

        (, , address _tokenAddress) = tokenFactory.deployedTokens(1);

        (
            string memory _name,
            string memory _symbol,
            uint256 _totalSupply
        ) = tokenFactory.getTokenData(_tokenAddress);

        assertEq(_name, name);
        assertEq(_symbol, symbol);
        assertEq(_totalSupply, totalSupply * (10 ** 18));
    }
}
