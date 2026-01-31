// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function test_SetOwner() public {
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    function testRevert_SetOwner() public {
        // vm.expectRevert("caller is not owner"); // default error
        vm.expectRevert(Wallet.NotOwner.selector); // custom error
        vm.prank(address(1));
        wallet.setOwner(address(1));
    }
}
