// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {MyTokenBaseTest} from "test/MyTokenBase.t.sol";

contract MyTokenTest is MyTokenBaseTest {
    function testTransferAcrossMultipleEOA() external checkChallengeSolved {
        // TODO: mint token
        // deployer mints 100 ether token
        // user1 mints 10 ether token
        // user2 mints 9 ether token
        // user3 mints 8 ether token
        vm.startPrank(deployer);
        token.mint(100 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(deployer), 100 ether);

        vm.startPrank(user1);
        token.mint(10 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), 10 ether);

        vm.startPrank(user2);
        token.mint(9 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user2), 9 ether);

        vm.startPrank(user3);
        token.mint(8 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user3), 8 ether);

        // TODO: transfer your token
        // user1 transfer 5 ether token to user2
        // user2 transfer 4 ether token to user3
        // user3 transfer 3 ether token to user1
        vm.startPrank(user1);
        token.transfer(user2, 5 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), 5 ether);
        assertEq(token.balanceOf(user2), 14 ether);

        vm.startPrank(user2);
        token.transfer(user3, 4 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user2), 10 ether);
        assertEq(token.balanceOf(user3), 12 ether);

        vm.startPrank(user3);
        token.transfer(user1, 3 ether);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), 8 ether);
        assertEq(token.balanceOf(user3), 9 ether);

        // TODO: transfer someone else's tokens
        // user1 approves 3 ether for user2
        // user2 transfers 2 ether from user1 to user3
        // retrieve the remaining allowance that user1 has given to user2
        // user2 transfers the remain allowance from user1 to user2
        vm.startPrank(user1);
        token.approve(user2, 3 ether);
        vm.stopPrank();

        vm.startPrank(user2);
        token.transferFrom(user1, user3, 2 ether);

        assertEq(token.balanceOf(user1), 6 ether);
        assertEq(token.balanceOf(user3), 11 ether);

        uint256 allowance = token.allowance(user1, user2);
        token.transferFrom(user1, user2, allowance);

        assertEq(token.balanceOf(user1), 5 ether);
        assertEq(token.balanceOf(user2), 11 ether);

        vm.stopPrank();
    }
}
