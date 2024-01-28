// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Token} from "./Token.sol";

contract TokenFactory {
    uint256 public tokenId;

    enum TokenType {
        BasicToken,
        AdvancedToken
    }

    event TokenCreated(
        address indexed _tokenAddress,
        string _name,
        string _symbol,
        uint256 _totalSupply,
        TokenType _tokenType
    );

    constructor() {
        tokenId = 1;
    }

    struct TokenInfo {
        uint256 idToken;
        TokenType tokenType;
        address tokenAddress;
    }

    mapping(uint256 => TokenInfo) public deployedTokens;

    function createToken(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        TokenType _tokenType
    ) public {
        if (_tokenType == TokenType.BasicToken) {
            Token basicToken = new Token(_name, _symbol, _totalSupply);
            deployedTokens[tokenId] = TokenInfo({
                idToken: tokenId,
                tokenType: TokenType.BasicToken,
                tokenAddress: address(basicToken)
            });
            emit TokenCreated(
                address(basicToken),
                _name,
                _symbol,
                _totalSupply,
                TokenType.BasicToken
            );
        }

        if (_tokenType == TokenType.AdvancedToken) {
            Token advancedToken = new Token(_name, _symbol, _totalSupply);
            deployedTokens[tokenId] = TokenInfo({
                idToken: tokenId,
                tokenType: TokenType.AdvancedToken,
                tokenAddress: address(advancedToken)
            });
            emit TokenCreated(
                address(advancedToken),
                _name,
                _symbol,
                _totalSupply,
                TokenType.AdvancedToken
            );
        }

        tokenId++;
    }

    function transferToken(
        address _tokenAddress,
        address _to,
        uint256 _value
    ) public {
        Token tokenInstance = Token(_tokenAddress);
        tokenInstance.transfer(_to, _value);
    }

    function getBalance(
        address _tokenAddress,
        address _account
    ) public view returns (uint256) {
        Token tokenInstance = Token(_tokenAddress);
        return tokenInstance.balances(_account);
    }

    function getTokenData(
        address _tokenAddress
    ) public view returns (string memory, string memory, uint256) {
        Token tokenInstance = Token(_tokenAddress);
        return (
            tokenInstance.name(),
            tokenInstance.symbol(),
            tokenInstance.totalSupply()
        );
    }
}
