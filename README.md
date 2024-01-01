# UUPSUpgradeable Proxy Project

## Overview

This project implements a smart contract using the UUPSUpgradeable proxy pattern. The proxy allows for seamless upgrades of the underlying logic contract while preserving the contract state. Two versions of the Box contract (BoxV1 and BoxV2) are provided to demonstrate the upgradeability feature.

## Contracts

### BoxV1

- Located in `src/BoxV1.sol`
- Implements the UUPSUpgradeable proxy pattern with OpenZeppelin contracts.
- Initializes an owner and exposes a `getNumber` function.

### BoxV2

- Located in `src/BoxV2.sol`
- Extends BoxV1, adding a `setNumber` function to update the stored number.
- Demonstrates the upgradeability feature by changing the contract's version.

### DeployBox

- Located in `script/DeployBox.s.sol`
- A deployment script that creates an instance of BoxV1 and deploys it using an ERC1967Proxy.

### UpgradeBox

- Located in `script/UpgradeBox.s.sol`
- An upgrade script that retrieves the most recently deployed ERC1967Proxy and upgrades it to BoxV2.

### DeployAndUpgradeTest

- Located in `test/DeployAndUpgradeTest.t.sol`
- Test suite for the deployment and upgrade processes. Checks contract versions and functionality after upgrades.

## Usage

### Compilation and Testing

To compile the contract, use the following command:

```bash
forge build
```

To test the contract, use the following command:

```bash
forge test
```
### Deployment

To deploy the contract using the DeployBox script, run the following command:

```bash
forge script script/DeployBox.s.sol:DeployBox --rpc-url $SEPOLIA_RPC_URL --account defaultKey --sender $MAIN_ADDRESS --verify --etherscan-api-key $ETHERSCAN_API_KEY --broadcast
```

Replace the environment variables (`$SEPOLIA_RPC_URL`, `$MAIN_ADDRESS`, `$ETHERSCAN_API_KEY`) with your specific values.

```bash
export SEPOLIA_RPC_URL=
```

### Upgrade Implementation

To upgrade the contract implementation using the UpgradeBox script, run the following command:

```bash
forge script script/UpgradeBox.s.sol:UpgradeBox --rpc-url $SEPOLIA_RPC_URL --account defaultKey --sender $MAIN_ADDRESS --verify --etherscan-api-key $ETHERSCAN_API_KEY --broadcast
```

Replace the environment variables (`$SEPOLIA_RPC_URL`, `$MAIN_ADDRESS`, `$ETHERSCAN_API_KEY`) with your specific values.

```bash
export SEPOLIA_RPC_URL=
```

Note: Ensure that you have the necessary environment variables set before running the deployment and upgrade scripts.