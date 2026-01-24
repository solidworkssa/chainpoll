# ChainPoll

Anonymous polling with multiple choice options on Base and Stacks.

## Features

- Create polls with options
- Anonymous voting
- Result tallying
- Time-based poll closure

## Contract Functions

### Base (Solidity)
- `createPoll(question, options, duration)` - Create poll
- `vote(pollId, optionIndex)` - Cast vote
- `getPoll(pollId)` - Get poll details
- `getVoteCount(pollId, option)` - Get vote tally

### Stacks (Clarity)
- `create-poll` - Create new poll
- `cast-vote` - Submit vote
- `get-poll` - Fetch poll info
- `get-vote-count` - Get vote count

## Quick Start

```bash
pnpm install
pnpm dev
```

## Deploy

```bash
pnpm deploy:base
pnpm deploy:stacks
```

## License

MIT
