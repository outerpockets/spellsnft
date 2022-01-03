// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './interfaces/IGridGenerator.sol';

contract GridGeneratorV1 is IGridGenerator {
  uint256 private constant BLOCK_GAP = 15;
  uint256 private constant DELAY = 50;
  uint256 private constant REMAP_MASK = 0xFF00000000000000000000000000000000000000000000000000000000000000;

  function viewGrid(uint256 _blockNumber) external view override returns (Grid memory) {
      return Grid(
        _remap(blockhash(_blockNumber - DELAY - BLOCK_GAP - (_blockNumber % BLOCK_GAP))),
        _remap(blockhash(_blockNumber - DELAY - (_blockNumber % BLOCK_GAP)))
      );
  }

  function _remap(bytes32 _letterBlocks) private pure returns (bytes32) {
    uint256 mutated = uint256(_letterBlocks);
    for (uint256 i;i<32;i++) {
      uint256 sampled = uint8(_letterBlocks[i]) >> 3;
      if (sampled > 25) {
        uint256 replacement;
        if (sampled == 26) {
          replacement = 0; // A
        }
        if (sampled == 27) {
          replacement = 4; // E
        }
        if (sampled == 28) {
          replacement = 8; // I
        }
        if (sampled == 29) {
          replacement = 13; // N
        }
        if (sampled == 30) {
          replacement = 14; // O
        }
        if (sampled == 31) {
          replacement = 19; // T
        }

        uint256 newBlock = ((replacement << 3) | (uint256(uint8(_letterBlocks[i])) & 7)) << (8 * (31 - i));
        uint256 mask = REMAP_MASK >> (8 * i);
        mutated = (mutated & ~mask) | newBlock;
      }
    }
    return bytes32(mutated);
  }
}