// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Auction} from "../src/Time.sol";
import {console} from "../lib/forge-std/src/console.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 public currentTime;
    uint256 public startAt;
    uint256 public endAt;

    function setUp() public {
        auction = new Auction();
        currentTime = block.timestamp;
    }

    function testRevert_bid() public {
        vm.warp(currentTime);
        vm.expectRevert("cannot bid"); // used to expect a revert
        auction.bid();
    }

    function test_bid() public {
        vm.warp(currentTime); // used to set the timestamp
        skip(3600 * 24); // means go forward 1 day
        auction.bid();
    }

    function testRevert_end() public {
        vm.warp(currentTime + 2 days); // used to set the timestamp
        rewind(3600 * 24); // means go back 1 day
        vm.expectRevert("cannot end");
        auction.end();
    }

    function test_end() public {
        vm.warp(currentTime + 2 days); // used to set the timestamp
        auction.end();
    }

    function test_blockNumber() public {
        vm.roll(200); // used to set the block number
        console.log("block.number", block.number);
        assertEq(block.number, 200);
    }
}
