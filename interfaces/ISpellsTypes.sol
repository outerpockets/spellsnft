// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

interface ISpellsTypes {
  struct Coord {
    uint256 x;
    uint256 y;
  }
  
  struct Grid {
    bytes32 top;
    bytes32 bottom;
  }

  struct TokenDetails {
    address owner;
    uint80 path;
    uint16 theme;
    uint192 word;
    uint40 reservationNumber;
    bytes3 backgroundColor;
  }

  struct AuxiliaryDetails {
    uint256 shape;
    uint256 letterBlocks;
    uint256 length;
  }
}