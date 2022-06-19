// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract ERC20Token {
    constructor(string memory name, string memory symbol) ERC20(name,symbol) {} 
}
