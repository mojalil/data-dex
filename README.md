# Data Marketplace dApp

[![GitHub license](https://img.shields.io/github/license/<your-github-username>/data-marketplace-dapp)](https://github.com/<your-github-username>/data-marketplace-dapp/blob/main/LICENSE)
[![GitHub issues](https://img.shields.io/github/issues/<your-github-username>/data-marketplace-dapp)](https://github.com/<your-github-username>/data-marketplace-dapp/issues)
[![Twitter Follow](https://img.shields.io/twitter/follow/motypes?style=social)](https://twitter.com/motypes)

Welcome to the Data Marketplace dApp project! This is a decentralized application built on the Ethereum blockchain, allowing users to sell, purchase, verify, and refine data.

## Table of Contents

- [Data Marketplace dApp](#data-marketplace-dapp)
  - [Table of Contents](#table-of-contents)
  - [About the Project](#about-the-project)
  - [Built With](#built-with)
  - [Todo List](#todo-list)
  - [Getting Started](#getting-started)
  - [Usage](#usage)
    - [Deployment Script](#deployment-script)
  - [Contributing](#contributing)
    - [Style Guide](#style-guide)
  - [License](#license)
  - [Contact](#contact)

## About the Project

This project aims to create a blockchain-based data marketplace where users can:

- Sell data
- Purchase data
- Verify the accuracy of data
- Refine and clean data

The project uses Solidity for smart contract development, Next.js for the front-end, and Foundry for testing and deployment.

## Built With

- [Solidity](https://soliditylang.org/)
- [Next.js](https://nextjs.org/)
- [Foundry](https://foundry.net/)

## Todo List
[] Add verification functionality to Data Contract
[] Add tests for purchase data, and verification function in Data Contract

## Getting Started

- Clone the repo: `git clone https://github.com/mojalil/data-marketplace-dapp.git`
- Install dependencies: `npm install`
- Start the local development server: `npm run dev`

## Usage

Once you have the dApp up and running, open a browser and connect your wallet to start particating

### Deployment Script

Run the deployment script with:
```
forge script script/DeployDataContract.s.sol
```

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


### Style Guide
We're using the solidy style guide: https://docs.soliditylang.org/en/v0.8.17/style-guide.html

Layout of Contract:
- version
- imports
- errors
- interfaces, libraries, contracts
- Type declarations
- State variables
- Events
- Modifiers
- Functions

Layout of Functions:
- constructor
- receive function (if exists)
- fallback function (if exists)
- external
- public
- internal
- private
- internal & private view & pure functions
- external & public view & pure functions

## License

Distributed under to be announced. See `LICENSE` for more information.

## Contact

Twitter: [@motypes](https://twitter.com/motypes)

Project Link: [https://github.com/mojalil/data-marketplace-dapp](https://github.com/mojalil/data-marketplace-dapp)
