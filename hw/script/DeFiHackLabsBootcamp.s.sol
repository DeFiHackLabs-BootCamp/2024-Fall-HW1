// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

interface IDeFiHackLabsBootCamp {
    function isRegister(uint256 number) external returns (bool);
    function isSignIn(uint256 number) external returns (bool);
    function register(uint256 number) external;
    function signIn(uint256 number, string calldata name, uint256 time, uint8 v, bytes32 r, bytes32 s) external;
}

contract DeFiHackLabsBootcampScript is Script {
    address public constant deFiHackLabsBootCamp = 0x1a53bD1e609Db5876df8CE01e516974f1A3A0A4f;

    function run() public {
        vm.startBroadcast();
        // TODO: call register function of DeFiHackLabsBootCamp with your number

        // TODO: call sign function with your number, name, time and signature
        vm.stopBroadcast();
    }
}
