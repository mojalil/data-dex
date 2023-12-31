# Data Marketplace Smart Contracts

[![Solidity Version](https://img.shields.io/badge/Solidity-0.8.18-blue?logo=solidity)](https://img.shields.io/badge/Solidity-0.8.18-blue?logo=solidity)
![Toolchain](https://img.shields.io/badge/Toolchain-Foundry-green)
[![Twitter Follow](https://img.shields.io/twitter/follow/motypes?style=social)](https://twitter.com/motypes)

Welcome to the Data Marketplace project! This is a decentralized application built on the Ethereum blockchain, allowing users to sell, purchase, verify, and refine data.

## Table of Contents

- [Data Marketplace Smart Contracts](#data-marketplace-smart-contracts)
  - [Table of Contents](#table-of-contents)
  - [About the Project](#about-the-project)
  - [Built With](#built-with)
  - [Companion Front End](#companion-front-end)
  - [Todo List](#todo-list)
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

The project uses Solidity for smart contract development for the front-end, and Foundry for testing and deployment.

## Built With

- [Solidity](https://soliditylang.org/)
- [Foundry](https://foundry.net/)

## Companion Front End
The front end for the data marketplace sit here: [Data Marketplace Frontend](https://github.com/mojalil/data-dex-frontend)
## Todo List
[] Add tests for purchase data, and verification function in Data Contract


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
