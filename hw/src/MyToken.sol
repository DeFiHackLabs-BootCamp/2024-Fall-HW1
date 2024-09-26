// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // TODO declare state variable, event, custom error here if you need

    constructor() {
        // TODO: assign `msg.sender` to a deployer variable
    }

    function mint(uint256 amount) external returns (uint256) {
        // TODO: This function allows users to mint MyToken token.
        // The maximum minted amount is 10 ether MyToken, but this limitation does not apply to the deployer
    }
}
