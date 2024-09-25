// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Test, console2} from "forge-std/Test.sol";
import {MyToken} from "src/MyToken.sol";

/**
 * DO NOT MODIFY THIS FILE, OR YOU WILL GET ZERO POINTS FROM THIS CHALLENGE
 */
interface IDeFiHackLabsBootCamp {
    function isRegister(uint256 number) external returns (bool);
    function isSignIn(uint256 number) external returns (bool);
    function students(uint256 number) external returns (address student);
}

contract MyTokenBaseTest is Test {
    // roles
    address internal deployer = makeAddr("deployer");
    address internal user1 = makeAddr("user1");
    address internal user2 = makeAddr("user2");
    address internal user3 = makeAddr("user3");

    MyToken internal token;

    // DeFiHackLabsBootCamp contract address on sepolia
    address internal constant deFiHackLabsBootCamp = 0xA75a02b1047eAD0760A95Ab88852005735e6D9e8;

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

    function testIsResister() public {
        uint256 number = vm.envUint("NUMBER");
        bool isRegister = IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isRegister(number);

        assertTrue(isRegister);
    }

    function testIsSignIn() public {
        uint256 number = vm.envUint("NUMBER");
        bool isSignIn = IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isSignIn(number);

        assertTrue(isSignIn);
    }

    function setUp() public virtual {
        vm.startPrank(deployer);
        token = new MyToken("MyToken", "MTK");
        vm.stopPrank();
    }
}
