// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Icomptroller {
    function enterMarkets(address[] calldata cTokens) external returns (uint[]memory);
}
