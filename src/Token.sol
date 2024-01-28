// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Token {
    error InsufficientBalance();

    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply * (10 ** 18);
        balances[msg.sender] += totalSupply;
    }

    function transfer(address _to, uint256 _value) public {
        if (balances[msg.sender] <= _value) {
            revert InsufficientBalance();
        }

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
    }
}
