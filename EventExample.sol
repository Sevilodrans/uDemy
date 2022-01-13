//SPDX-License-Identifier: MIT

pragma solidity 0.8.11;

// start our contract
contract EventExample {

    mapping(address => uint) public tokenBalance;

    string public myString;

    uint public myUint;

    // create the event to be placed into the transaction. The event will trigger when the "emit" is run.
    event TokensSent(address _from, address _to, uint _amount);

    constructor() {
        tokenBalance[msg.sender] = 100;
    }

    function setUint(uint _uint) public {
        myUint = _uint;
    }

    function setMyString(string memory _string) public {
        myString = _string;
    }

    function sendToken(address _to, uint _amount) public returns(bool) {
    
        require(tokenBalance[msg.sender] >= _amount, "not enough tokens!");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);

        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;

        emit TokensSent(msg.sender, _to, _amount);

        return true;
    }

}