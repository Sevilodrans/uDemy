//SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

contract WillThrow {
        function aFunction() public {
            require(false, "This is the error message that will be sent/emitted.");
        }
}

contract ErrorHandling {
    event ErrorLogging(string reason);
    function catchError() public{
        WillThrow will = new WillThrow();
        try will.aFunction() {

        } catch Error(string memory reason) {
            emit ErrorLogging(reason);
        }
    }
}