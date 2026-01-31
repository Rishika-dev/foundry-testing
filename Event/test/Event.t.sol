// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Test} from "../lib/forge-std/src/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    Event public eventContract;
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        eventContract = new Event();
    }

    function test_SingleEventEmit() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(1), 100);
        eventContract.transfer(address(this), address(1), 100);
    }

    function test_MultipleEventEmit() public {
        address[] memory to = new address[](2);
        to[0] = address(1);
        to[1] = address(2);
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100;
        amounts[1] = 200;
        for (uint256 i = 0; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
            eventContract.transfer(address(this), to[i], amounts[i]);
        }
    }
}
