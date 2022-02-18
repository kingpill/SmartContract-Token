SMART CONTRACT TOKEN

Smart token contract created in solidity (using openzeppelin and hardhat(for testing)) with the following functions:

1. Upgradeable (through proxy)
2. Burnable
3. Mintable (up to the initial supply of 120,000,000). Attempting to mint anything above the initial supply will fail. Only admin(s) with 'minter' role can mint new tokens.
4. Pausable: All transactions of the token can be halted by the admin in case of security threats
5. Access control: The developers of the tokens can be given access to certain functions in order to upgrade and change only that specific function
6. Flash loans- Function to grant flashloans(loans given and paid back in the same transaction without a deposit or collateral, granted only if the transaction succeeds).
7. Votes: Holders of the token will be able to vote(through a DAO) on certain aspects for the token developers to be guided by. Further features need to be built for this to be complete.

Built with ERC20 protocol and compatible with EVM. Can be used on any EVM compatible network such as Ethereum, Binance Smart Chain or Tron.
