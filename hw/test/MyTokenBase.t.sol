// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import {MyToken} from "src/MyToken.sol";

/**
 * DO NOT MODIFY THIS FILE, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE
 */
contract MyTokenBaseTest is Test {
    // roles
    address internal deployer = makeAddr("deployer");
    address internal user1 = makeAddr("user1");
    address internal user2 = makeAddr("user2");
    address internal user3 = makeAddr("user3");

    MyToken internal token;

    modifier checkChallengeSolved() {
        // validate mint function
        vm.startPrank(user1);
        vm.expectRevert(MyToken.InvalidAmount.selector);
        token.mint(11 ether);
        vm.stopPrank();

        vm.startPrank(user2);
        vm.expectRevert(MyToken.InvalidAmount.selector);
        token.mint(11 ether);
        vm.stopPrank();

        vm.startPrank(user3);
        vm.expectRevert(MyToken.InvalidAmount.selector);
        token.mint(11 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(deployer), 0 ether);
        assertEq(token.balanceOf(user1), 0 ether);
        assertEq(token.balanceOf(user2), 0 ether);
        assertEq(token.balanceOf(user3), 0 ether);
        _;

        assertEq(token.balanceOf(user1), 5 ether);
        assertEq(token.balanceOf(user2), 11 ether);
        assertEq(token.balanceOf(user3), 11 ether);
        assertEq(token.balanceOf(deployer), 100 ether);
    }

    function setUp() public {
        vm.startPrank(deployer);
        token = new MyToken("MyToken", "MTK");
        vm.stopPrank();
    }
}
