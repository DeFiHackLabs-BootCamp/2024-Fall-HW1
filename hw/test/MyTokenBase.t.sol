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

    function stringToUint(string memory s) private pure returns (uint256) {
        bytes memory b = bytes(s);
        uint256 number = 0;

        for (uint256 i = 0; i < b.length; i++) {
            require(b[i] >= 0x30 && b[i] <= 0x39, "Fail");
            number = number * 10 + (uint256(uint8(b[i])) - 48);
        }

        return number;
    }

    function testStringToUint() public {
        string[54] memory stringNum = [
            "1",
            "2",
            "3",
            "4",
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13",
            "14",
            "15",
            "16",
            "17",
            "18",
            "19",
            "20",
            "21",
            "22",
            "23",
            "24",
            "25",
            "26",
            "27",
            "28",
            "29",
            "30",
            "31",
            "32",
            "33",
            "34",
            "35",
            "36",
            "37",
            "38",
            "39",
            "40",
            "41",
            "42",
            "43",
            "44",
            "45",
            "46",
            "47",
            "48",
            "49",
            "50",
            "51",
            "52",
            "53",
            "54"
        ];

        for (uint256 i = 1; i < 55; ++i) {
            uint256 number = stringToUint(stringNum[i - 1]);
            assertEq(i, number);
        }
    }

    function testIsResister() public {
        string memory path = "./number.txt";
        string memory numberString = vm.readFile(path);
        uint256 number = stringToUint(numberString);

        bool isRegister = IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isRegister(number);

        assertTrue(isRegister);
    }

    function testIsSignIn() public {
        string memory path = "./number.txt";
        string memory numberString = vm.readFile(path);
        uint256 number = stringToUint(numberString);

        bool isSignIn = IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isSignIn(number);

        assertTrue(isSignIn);
    }

    function setUp() public virtual {
        vm.startPrank(deployer);
        token = new MyToken("MyToken", "MTK");
        vm.stopPrank();
    }
}
