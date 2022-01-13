// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

contract Owned {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not the contract owner");
        _;
    }

}