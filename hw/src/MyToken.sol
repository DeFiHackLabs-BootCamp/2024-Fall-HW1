// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // TODO declare state variable, event, custom error here if you need

    constructor() {
        // TODO: Mint 1000 tokens to the contract at deployment
    }

    function mint(uint256 amount) external returns (uint256) {
        // TODO: This function allows users to mint token.
        // The maximum minted amount is 10 ether, but this limitation does not apply to the deployer
    }
}
