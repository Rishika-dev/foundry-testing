//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {Test} from "../lib/forge-std/src/Test.sol";
import {Counter} from "../src/Counter.sol";
import {stdError} from "../lib/forge-std/src/StdError.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_Increment() public {
        counter.inc();
        assertEq(counter.get(), 1);
    }

    function test_Decrement() public {
        counter.inc();
        counter.dec();
        assertEq(counter.get(), 0);
    }

    function test_failed_decrement() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }
}
