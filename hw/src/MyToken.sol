// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // TODO declare state variable, event, custom error here if you need
    address public immutable deployer;

    mapping(address user => uint256 stakedAmount) public balance;

    error ZeroAmount();
    error InvalidAmount();

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        // TODO: Mint 1000 tokens to the contract at deployment
        deployer = msg.sender;
    }

    function mint(uint256 amount) external returns (uint256) {
        // TODO: This function allows users to mint token.
        // The maximum minted amount is 10 ether, but this limitation does not apply to the deployer
        if (amount == 0) revert ZeroAmount();

        balance[msg.sender] += amount;

        if (msg.sender == deployer) {
            _mint(msg.sender, amount);
        } else {
            if (balance[msg.sender] > 10 ether) revert InvalidAmount();
            _mint(msg.sender, amount);
        }

        return amount;
    }
}
