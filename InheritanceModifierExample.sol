// SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

// Import the file "owned.sol" that we will be inheriting modifiers from
import "./Owned.sol";

// define the contract and inherit from the imported contract
contract InheritanceModifierExample is Owned {

    // define the mapping for address to uint for balance of token per address.
    mapping(address => uint) public tokenBalance;

    // initiate the price per token
    uint tokenPrice = 1 ether;

    // Constructor to be run upon contract create to create 100 tokens for the owner.
    constructor() {
        tokenBalance[owner] = 100;
    }

    // Function to add tokens to the owners balance, uses the modifier so that only can be called by owner.
    function createNewToken() public onlyOwner{
        // add tokens to the tokenBalance mapping of the owner address.
        tokenBalance[owner] ++;
    }

    // Function to remove tokens from owners balance, uses the modifier so only can be called by owner.
    function burnToken() public onlyOwner {
        // 'test' to make sure that the token balance of the owner is not equal to 0, need tokens to burn tokens
        assert(tokenBalance[owner] != 0);
        tokenBalance[owner]--;
    }

    // function for publi to purchase tokens
    function purchaseToken() public payable {
        // require that the owners balance, multiplied by the price, divided by the value submitted in the message is greater than 0
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "Not enough Tokens");
        // subtract the purchased tokens from the balance of the owner.
        tokenBalance[owner] -= msg.value / tokenPrice;
        // add the purchased amount of tokens to the buyers balance.
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }

    // function to send token amount to an address
    function sendToken(address _to, uint _amount) public {
        // require that the balance of the sender is greater than the amount they are trying to send.
        require(tokenBalance[msg.sender] >= _amount, "not enough tokens");
        // make sure that the balance and what is being sent is greater than the current balance of receiver.
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        // make sure that the balance and sent token amount of the sender is less than or equal to the current sender balance.
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        // remove the sent tokens from the senders balance
        tokenBalance[msg.sender] -= _amount;
        // add the sent tokens to the receivers balance.
        tokenBalance[_to] += _amount;
    }



}