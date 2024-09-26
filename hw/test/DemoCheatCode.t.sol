// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import "forge-std/console.sol";

contract Demo {
    event DoNothing();
    event DoSomething();

    error RevertWhatever();

    function msgSender() public view {
        console.log(msg.sender);
    }

    function doNothing() public {
        // internalSuccess();
        // internalFail();
        emit DoNothing();
    }

    function revertWhatever() public pure {
        revert RevertWhatever();
    }

    function internalSuccess() internal {
        emit DoSomething();
    }

    function internalFail() internal pure {
        revert RevertWhatever();
    }
}

contract DemoCheatCodeTest is Test {
    // Vm.sol path: hw/lib/forge-std/src/Vm.sol
    address player;
    Demo demo;

    function setUp() public {
        player = address(0x1234);
        demo = new Demo();
    }

    function testPrank() external {
        vm.startPrank(player, player);
        demo.msgSender();
        vm.stopPrank();
    }

    function testDeal() external {
        console.log(player.balance);
        vm.deal(player, 1000 ether);
        console.log(player.balance);
    }

    function testRoll() external {
        console.log(block.number);
        vm.roll(100);
        console.log(block.number);
    }

    function testWarp() external {
        console.log(block.timestamp);
        vm.warp(1234);
        console.log(block.timestamp);
    }

    function testExpectEmit() external {
        vm.expectEmit(false, false, false, false);
        emit Demo.DoNothing();

        demo.doNothing();
    }

    function testExpectRevert() external {
        vm.expectRevert();
        demo.revertWhatever();
    }

    function testCreateSelectFork() external {
        // https://sepolia.etherscan.io/
        vm.createSelectFork("sepolia");
        console.log(block.number);
        console.log(block.chainid);
    }

    function testInternalTrace() external {
        // uncomment the `internalSuccess` and `internalFail` functions in `doNothing` function
        demo.doNothing();
    }
}
