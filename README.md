# 09-chainpoll - Base Native Architecture

> **Built for the Base Superchain & Stacks Bitcoin L2**

This project is architected to be **Base-native**: prioritizing onchain identity, low-latency interactions, and indexer-friendly data structures.

## 🔵 Base Native Features
- **Smart Account Ready**: Compatible with ERC-4337 patterns.
- **Identity Integrated**: Designed to resolve Basenames and store social metadata.
- **Gas Optimized**: Uses custom errors and batched call patterns for L2 efficiency.
- **Indexer Friendly**: Emits rich, indexed events for Subgraph data availability.

## 🟠 Stacks Integration
- **Bitcoin Security**: Leverages Proof-of-Transfer (PoX) via Clarity contracts.
- **Post-Condition Security**: Strict asset movement checks.

---
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
