// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/ERC20Upgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/security/PausableUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/access/AccessControlUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/extensions/draft-ERC20PermitUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/token/ERC20/extensions/ERC20FlashMintUpgradeable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts-upgradeable/blob/master/contracts/proxy/utils/Initializable.sol";

contract Token is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, PausableUpgradeable, AccessControlUpgradeable, ERC20PermitUpgradeable, ERC20VotesUpgradeable, ERC20FlashMintUpgradeable {
bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

constructor() initializer {}

function initialize() initializer public {
__ERC20_init(“myToken",  “myToken");
__ERC20Burnable_init();
__Pausable_init();
__AccessControl_init();
__ERC20Permit_init(“myToken");
__ERC20FlashMint_init();

_grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
_grantRole(PAUSER_ROLE, msg.sender);
_mint(msg.sender, 120000000 * 18 ** decimals());
}

function pause() public onlyRole(PAUSER_ROLE) {
_pause();
}
function unpause() public onlyRole(PAUSER_ROLE) {
_unpause();
}

function _beforeTokenTransfer(address from, address to, uint256 amount)
internal
whenNotPaused
override
{
super._beforeTokenTransfer(from, to, amount);
}


function _afterTokenTransfer(address from, address to, uint256 amount)
internal
override(ERC20Upgradeable, ERC20VotesUpgradeable)
{
super._afterTokenTransfer(from, to, amount);
}

function _mint(address to, uint256 amount)
internal
override(ERC20Upgradeable, ERC20VotesUpgradeable)
{
require(totalSupply() + amount <= 120000000 * 18 ** decimals(), "Max number of tokens minted");
super._mint(to, amount);
}
function _burn(address account, uint256 amount)
internal
override(ERC20Upgradeable, ERC20VotesUpgradeable)
{
super._burn(account, amount);
}
}
