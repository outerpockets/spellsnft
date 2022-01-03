// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

interface IMint {
  function mint(address _to, uint256 _tokenId) external;
}