//SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.13;

contract Wallet {
    address payable public owner;

    event Deposit(address account, uint256 amount);

    error NotOwner();

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        owner = payable(_owner);
    }
}
