# csi_train_chainlink

This repository contains Chainlink oracle infrastructure for the train delay protection prototype. It demonstrates how blockchain oracles can be used to fetch and provide external data to smart contracts. Additionally, it includes a small test integration with Gelato for automation purposes.

## Repository Structure

- `contracts/` - Solidity smart contracts for Chainlink oracle and Gelato integration
  - Oracle contracts for handling external data requests
  - Consumer contracts for processing and forwarding train delay data
  - Gelato resolver contracts for automation
- `jobs/` — Chainlink job specifications (TOML files) for data fetching
  - Train delay data fetching jobs
  - Data processing and formatting jobs
  - Test jobs for development and debugging

## Technologies Used

### Chainlink
Chainlink is a decentralized oracle network that enables smart contracts to securely access off-chain data feeds, web APIs, and traditional bank payments.

- **Documentation**: [Chainlink Docs](https://docs.chain.link/)
- **Developer Resources**: [Chainlink Developer Hub](https://dev.chain.link/)
- **Job Specifications**: [Chainlink Jobs](https://docs.chain.link/chainlink-nodes/oracle-jobs/all-jobs/)

### Gelato
Gelato is a decentralized automation protocol that enables developers to automate smart contract executions on various blockchains.

- **Website**: [Gelato Network](https://www.gelato.network/)
- **Documentation**: [Gelato Docs](https://docs.gelato.network/)

## ⚠️ Important Notice

This repository contains experimental code and may be deprecated due to changes in the Chainlink or Gelato protocols. Always refer to the latest documentation and protocol specifications before using this code in production environments. The job specifications and contract interfaces may no longer be compatible with current versions of these protocols.
