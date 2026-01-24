// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Poll {
    struct PollData {
        uint256 id;
        address creator;
        string question;
        string[] options;
        uint256 endTime;
        bool active;
        uint256 totalVotes;
    }

    mapping(uint256 => PollData) public polls;
    mapping(uint256 => mapping(uint256 => uint256)) public voteCounts;
    mapping(uint256 => mapping(address => bool)) public hasVoted;
    uint256 public pollCount;

    event PollCreated(uint256 indexed pollId, address creator, string question);
    event VoteCast(uint256 indexed pollId, uint256 optionIndex);

    function createPoll(
        string memory _question,
        string[] memory _options,
        uint256 _duration
    ) external returns (uint256) {
        uint256 pollId = pollCount++;

        polls[pollId] = PollData({
            id: pollId,
            creator: msg.sender,
            question: _question,
            options: _options,
            endTime: block.timestamp + _duration,
            active: true,
            totalVotes: 0
        });

        emit PollCreated(pollId, msg.sender, _question);

        return pollId;
    }

    function vote(uint256 _pollId, uint256 _optionIndex) external {
        PollData storage poll = polls[_pollId];
        require(poll.active, "Poll not active");
        require(block.timestamp < poll.endTime, "Poll ended");
        require(!hasVoted[_pollId][msg.sender], "Already voted");
        require(_optionIndex < poll.options.length, "Invalid option");

        hasVoted[_pollId][msg.sender] = true;
        voteCounts[_pollId][_optionIndex]++;
        poll.totalVotes++;

        emit VoteCast(_pollId, _optionIndex);
    }

    function getPoll(uint256 _pollId) external view returns (PollData memory) {
        return polls[_pollId];
    }

    function getVoteCount(uint256 _pollId, uint256 _optionIndex) external view returns (uint256) {
        return voteCounts[_pollId][_optionIndex];
    }
}
