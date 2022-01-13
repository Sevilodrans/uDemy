//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract MappingsStructExample {

    // Define the struct for payments - eth in and when.
    struct Payment {
        uint amount;
        uint timestamps;
    }   

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;

    // get the balance of this smart contract.
    function getBalance() public view returns(uint) {
        // return the balance of 'this' contracts address.
        return address(this).balance;
    }

    // function to send money to this contract
    function sendMoney() public payable {
            // increase the total balance of the Sender
            balanceReceived[msg.sender].totalBalance += msg.value;

            // create the type Payment to be using the the Balance mapping Payment
            Payment memory payment = Payment(msg.value, block.timestamp);
            // Add the payment to the mapping, the .payments[balanceReceived[msg.sender.numPayments] is the key for the payment value
            // in the payments mapping in our Balance struct
            balanceReceived[msg.sender].payments[balanceReceived[msg.sender].numPayments] = payment;
            // increment the numPayments by 1, which will the key for the payment value next time this sender deposits ETH.
            balanceReceived[msg.sender].numPayments++;
    }

    function showPayments(address _key, uint _key2) public view returns(uint) {
        return balanceReceived[_key].payments[_key2].amount;
    }
    //function to partially withdraw money from this smart contract.
    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender].totalBalance, "Not enough funds!");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
    
    // function to withdraw all money from this smart contract to the '_to' address.
    function withdrawAllMoney(address payable _to) public {
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        balanceReceived[msg.sender].totalBalance = 0;
        _to.transfer(balanceToSend);
    }

}