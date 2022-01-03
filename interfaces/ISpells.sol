// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './ISpellsTypes.sol';

interface ISpells is ISpellsTypes {
  function tokens(uint256 _tokenId) external view returns (TokenDetails memory);
}