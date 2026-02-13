// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title ChainPoll Contract
/// @notice On-chain polling and surveys.
contract ChainPoll {

    struct Poll {
        string question;
        string[] options;
        uint256[] votes;
        uint256 deadline;
    }
    
    Poll[] public polls;
    
    function createPoll(string memory _q, string[] memory _opts, uint256 _duration) external {
        uint256[] memory initVotes = new uint256[](_opts.length);
        polls.push(Poll({
            question: _q,
            options: _opts,
            votes: initVotes,
            deadline: block.timestamp + _duration
        }));
    }
    
    function vote(uint256 _pollId, uint256 _optionId) external {
        Poll storage p = polls[_pollId];
        require(block.timestamp < p.deadline, "Poll ended");
        p.votes[_optionId]++;
    }

}
