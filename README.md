# Complex Token Factory Smart Contract

## Overview

The Complex Token Factory Smart Contract is a decentralized solution for creating sophisticated tokens with customizable features. It consists of two primary contracts: Token Factory and Token. This system provides users with the flexibility to choose between basic and advanced token configurations, allowing for tailored token deployments.

## Contracts

### 1. Token Factory

The Token Factory contract acts as the central hub for creating both basic and advanced tokens. Users can interact with the Token Factory to deploy new tokens with specific features and complexities.

#### Functions:

- `createToken`: Function to create new token
- `transferToken`: Function to transfer token
- `getBalance`: Function to view the token balance owned by a specific address
- `getTokenData`: Function to view token data

### 2. Token

The Token contract represents the individual tokens created by the Token Factory.

### Functions:

- `transfer`: Function to transfer token

## Contract Address

- Token contract = 0x149dBBD9563275CfA5c3aE8aA8F273261b62Ab22
- Token factory contract = 0x060813A7037c31f208F7FD521C2705a2EC6D12E9
