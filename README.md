SMART CONTRACT TOKEN

Smart token contract created in solidity (using openzeppelin and hardhat(for testing)) with the following functions:

1. Upgradeable (through proxy)
2. Burnable
3. Mintable (up to the initial supply of 120,000,000). Attempting to mint anything above the initial supply will fail, unless done for a flashloan.
4. Pausable: All transactions of the token can be halted by the admin in case of security threats
5. Access control: The developers of the tokens can be given access to certain functions in order to upgrade and change only that specific function
6. Flash loans- Ability to mint extra tokens to grant flash loans. Tokens will be minted and burnt in the same transaction, thus not increasing the overall number of tokens.
7. Votes: Holders of the token will be able to vote(through a DAO) on certain aspects. Further features need to be build for this to be complete.

Built with ERC20 protocol and compatible with EVM.
