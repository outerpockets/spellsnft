// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './ISpellsTypes.sol';

interface ITheme is ISpellsTypes {
  function canUseTheme(
    uint256 _tokenId,
    TokenDetails calldata _currTokenDetails,
    TokenDetails calldata _nextTokenDetails
  ) external view returns (bool);

  function characterSet() external view returns (string[] calldata);
  
  function extendedAttributes(
    uint256 _tokenId,
    TokenDetails calldata _tokenDetails,
    AuxiliaryDetails calldata _auxDetails
  ) external view returns (string calldata);

  function extendedProperties(
    uint256 _tokenId,
    TokenDetails calldata _tokenDetails,
    AuxiliaryDetails calldata _auxDetails
  ) external view returns (string calldata);
  
  function renderSvg(
    uint256 _tokenId,
    TokenDetails calldata _tokenDetails,
    AuxiliaryDetails calldata _auxDetails
  ) external view returns (string calldata);
}