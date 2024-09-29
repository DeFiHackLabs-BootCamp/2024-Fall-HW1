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
    address public constant deFiHackLabsBootCamp = 0xA75a02b1047eAD0760A95Ab88852005735e6D9e8;

    function run() public {
        vm.startBroadcast();
        // TODO: call register function of DeFiHackLabsBootCamp with your number
        IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).register(1);
        IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isRegister(1);

        bytes32 hash = keccak256(abi.encode(1, "Alex", block.timestamp));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(hash);

        // TODO: call sign function with your number, name, time and signature
        IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).signIn(1, "Alex", block.timestamp, v, r, s);
        IDeFiHackLabsBootCamp(deFiHackLabsBootCamp).isSignIn(1);
        vm.stopBroadcast();
    }
}
