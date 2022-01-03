// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './ISpellsTypes.sol';

interface IGridGenerator is ISpellsTypes {
  function viewGrid(uint256 _blockNumber) external view returns (Grid memory);
}