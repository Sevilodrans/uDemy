// SPDX-License-Identifier: MIT

pragma solidity 0.5.13;

contract ExceptionExample {

    // create a mapping for the Balance Received from the sender.
    mapping (address => uint) public balanceReceived;

    address payable owner;

    constructor() public {
        owner = msg.sender;
    }

    function getOwner() public view returns(address){
        return owner;
    }

    function convertWeiToEth(uint _amount) public pure returns(uint) {
        return _amount / 1 ether;
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    // public payable function to receive money to the smart Contract.
    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;

    }

    // public function to withdraw money that has been deposited to the contract.
    function withdrawMoney(address payable _to, uint _amount) public {
        // check that the withdrawal amount is less then or equal to the total balance of the address.
        require(_amount <= balanceReceived[msg.sender], "you don't have enough Ether!") ;
        // Assert that the balance is more than the balance subracting the amout to withdrawal
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
            // if the address has enough funds, subtract this from the total balance of this address.
            balanceReceived[msg.sender] -= _amount;
            //transfer the amount to the _to address
            _to.transfer(_amount);
    }

    function () external payable {
       receiveMoney(); 
    }
}