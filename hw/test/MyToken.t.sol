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

        // TODO: transfer your token
        // user1 transfer 5 token to user2
        // user2 transfer 4 token to user3
        // user3 transfer 3 token to user1

        // TODO: transfer someone else's tokens
        // user1 approves 3 Ether for user2
        // user2 transfers 2 Ether from user1 to user3
        // retrieve the remaining allowance that user1 has given to user2
        // user2 transfers the remain allowance from user1 to user2
    }
}
