// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import './interfaces/ISpellsTypes.sol';

library SpellsUtils {
  uint256 constant private M1               = 0x0000000000000000000000000000000000000000000000005555555555555555;
  uint256 constant private M2               = 0x0000000000000000000000000000000000000000000000003333333333333333;
  uint256 constant private M4               = 0x0000000000000000000000000000000000000000000000000F0F0F0F0F0F0F0F;
  uint256 constant private FULL_COL         = 0x0000000000000000000000000000000000000000000000008080808080808080;
  uint256 constant private FULL_ROW         = 0x000000000000000000000000000000000000000000000000FF00000000000000;
  uint256 constant private COLOR_MASK       = 0x0000000000000000070707070707070707070707070707070707070707070707;
  uint256 constant private COORD_MASK       = 0x00000000000000000000000000000000000000000000FC000000000000000000;
  uint256 constant private DIR_MASK         = 0x0000000000000000000000000000000000000000000003800000000000000000;
  uint256 constant private GRID_BLOCK_MASK  = 0xF800000000000000000000000000000000000000000000000000000000000000;
  uint256 constant private LETTER_MASK      = 0x0000000000000000FF0000000000000000000000000000000000000000000000;
  uint256 constant private WORD_MASK        = 0x0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  bytes16 constant private HEX_SYMBOLS = "0123456789ABCDEF";

  function cleanPath(uint256 _path, uint256 _length) internal pure returns (uint256) {
    uint256 pathMask;
    for (uint256 i; i<_length-1; i++) {
      pathMask = DIR_MASK | (pathMask >> 3);
    }
    return (COORD_MASK | pathMask) & _path;
  }

  function combineToId(uint256 _bitboard, uint256 _letters) internal pure returns (uint256) {
    return (_bitboard << 192) | _letters;
  }

  function generateSpellGrid(uint256 _bitboard, uint256 _letters, uint256 _length) internal pure returns (ISpellsTypes.Grid memory) {
    bytes memory topHalf = new bytes(32);
    bytes memory bottomHalf = new bytes(32);
    uint256 letterIndex = 0;
    for(uint256 i; i<64 && letterIndex < _length; i++) {
      if(_bitboard & (1 << (63 - i)) != 0) {
        if (i<32) {
          topHalf[i] = bytes1(uint8(SpellsUtils.getLetterBlock(_letters, letterIndex)));
        } else {
          bottomHalf[i-32] = bytes1(uint8(SpellsUtils.getLetterBlock(_letters, letterIndex)));
        }
        letterIndex++;
      }
    }
    return ISpellsTypes.Grid(
      bytes32(topHalf),
      bytes32(bottomHalf)
    );
  }

  function getColorway(uint256 _tokenId, uint256 _length) internal pure returns (uint256) {
    bytes24 masked = bytes24(uint192(_tokenId & COLOR_MASK));
    uint256 colorBitField;
    for (uint256 i; i<_length; i++) {
      colorBitField |= uint256(1) << uint8(masked[i]);
    }
    return colorBitField;
  }

  function getLetterBlock(
    uint256 _letterBlockData,
    uint256 _index
  ) internal pure returns (uint256) {
    return uint8(bytes24(uint192(_letterBlockData))[_index]);
  }
  
  function getLetterBlocks(uint256 _tokenId) internal pure returns (uint256) {
    return uint192(_tokenId);
  }

  function getShape(uint256 _tokenId) internal pure returns (uint256) {
    return _tokenId >> 192;
  }

  function getShapeString(uint256 _bitboard) internal pure returns (string memory) {
    bytes8 spliced = bytes8(uint64(_bitboard));
    return string(
      abi.encodePacked(
        _toBoxString(uint8(spliced[0])), '\\n',
        _toBoxString(uint8(spliced[1])), '\\n',
        _toBoxString(uint8(spliced[2])), '\\n',
        _toBoxString(uint8(spliced[3])), '\\n',
        _toBoxString(uint8(spliced[4])), '\\n',
        _toBoxString(uint8(spliced[5])), '\\n',
        _toBoxString(uint8(spliced[6])), '\\n',
        _toBoxString(uint8(spliced[7]))
      )
    );
  }

  function getCharacters(
    uint256 _letterBlocks,
    uint256 _length
  ) internal pure returns (uint256) {
    uint256 word = WORD_MASK;
    uint256 letterCode;
    for (uint256 i; i < _length; i++) {
      letterCode = getLetterBlock(_letterBlocks, i) >> 3;
      word = (word & ~(LETTER_MASK >> i * 8)) | (letterCode << (23 - i) * 8);
    }
    return word;
  }
  
  function getWord(
    ISpellsTypes.Grid memory _grid,
    uint256 _path,
    uint256 _length
  ) internal pure returns (uint256) {
    ISpellsTypes.Coord memory currentPosition = ISpellsTypes.Coord(
        ((uint256(7) << 77) & _path) >> 77,
        ((uint256(7) << 74) & _path) >> 74
    );
    uint256 word = WORD_MASK;
    uint256 mask;
    uint256 letterCode;
    for (uint256 i; i < _length; i++) {
      if (i != 0) {
        uint256 dir = ((uint256(7) << (74 - (3 * i))) & _path) >> (74 - (3 * i));
        (currentPosition.x, currentPosition.y) = _walk(currentPosition.x, currentPosition.y, dir);
      }
      
      if (currentPosition.y < 4) {
        mask = GRID_BLOCK_MASK >> (64 * currentPosition.y + 8 * currentPosition.x);
        letterCode = (uint256(_grid.top) & mask) >> (248 - 64 * currentPosition.y - 8 * currentPosition.x) >> 3;
        word = (word & ~(LETTER_MASK >> i * 8)) | (letterCode << (23 - i) * 8);
      } else {
        mask = GRID_BLOCK_MASK >> (64 * (currentPosition.y - 4) + 8 * currentPosition.x);
        letterCode = (uint256(_grid.bottom) & mask) >> (248 - 64 * (currentPosition.y - 4) - 8 * currentPosition.x) >> 3;
        word = (word & ~(LETTER_MASK >> i * 8)) | (letterCode << (23 - i) * 8);
      }
    }
    return word;
  }

  struct ShiftCounter {
    uint256 i;
    uint256 leftshift;
    uint256 upshift;
  }

  function normalize(uint256 _bitboard, uint256 _letters , uint256 _path, uint256 _length) internal pure
  returns (uint256 normalizedBitboard_, uint256 normalizedLetters_, uint256 normalizedPath_) {
    ShiftCounter memory shifts;
    uint256 x = ((uint256(7) << 77) & _path) >> 77;
    uint256 y = ((uint256(7) << 74) & _path) >> 74;
    uint256 letterMask = LETTER_MASK;
    uint256 pathMask;

    for (shifts.i=0; shifts.i<_length-1; shifts.i++) {
      letterMask = LETTER_MASK | (letterMask >> 8);
      pathMask = DIR_MASK | (pathMask >> 3);
    }

    for (shifts.i=0;shifts.i<8;shifts.i++) {
      if (_bitboard & (FULL_ROW >> (8 * shifts.i)) != 0) {
        shifts.upshift = shifts.i;
        break;
      }
    }

    for (shifts.i=0;shifts.i<8;shifts.i++) {
      if (_bitboard & (FULL_COL >> shifts.i) != 0) {
        shifts.leftshift = shifts.i;
        break;
      }
    }
    
    x = (x - shifts.leftshift) << 77;
    y = (y - shifts.upshift) << 74;
    return (_bitboard << (8 * shifts.upshift) << shifts.leftshift, _letters & letterMask, _path & pathMask | x | y);
  }

  // only works for uint64
  function popCount(uint256 x) internal pure returns (uint256 pop_) {
    x -= (x >> 1) & M1;
    x = (x & M2) + ((x >> 2) & M2);
    x = (x + (x >> 4)) & M4;
    x += x >>  8;
    x += x >> 16;
    x += x >> 32;
    return x & 0x7f;
  }

  function renderText(uint256 _word, string[] memory _characterSet) internal pure returns (string memory) {
    bytes memory buffer;
    for (uint256 i;i<24;i++) {
      uint256 letterCode = (_word & (LETTER_MASK >> i * 8)) >> (23 - i) * 8;
      if (letterCode == 0xFF) {
        break;
      } else if (letterCode < _characterSet.length) {
        buffer = abi.encodePacked(buffer, _characterSet[letterCode]);
      } else {
        buffer = abi.encodePacked(buffer, _characterSet[_characterSet.length-1]);
      }
    }
    return string(buffer);
  }

  function sortLetters(uint256 _word, uint256 _length) internal pure returns (uint256) {
    uint256[24] memory copy;
    for (uint256 i; i < 24; i++) copy[i] = (_word & (LETTER_MASK >> i * 8)) >> (23 - i) * 8;
    _quickSort(copy, 0, _length - 1);
    uint256 sorted;
    for (uint256 i; i < 24; i++) sorted |= copy[i] << (23 - i) * 8;
    return sorted;
  }

  function toColorHexString(uint256 _value) internal pure returns (string memory) {
    bytes memory buffer = new bytes(6);
    for (uint256 i; i < 6; i++) {
        buffer[i] = HEX_SYMBOLS[(_value & 0xF00000) >> 20];
        _value <<= 4;
    }
    return string(buffer);
  }

  function _quickSort(uint256[24] memory _word, uint256 _left, uint256 _right) internal pure {
    if (_left >= _right) {
      return;
    }
    uint256 pivot = _word[(_left+_right)/2];
    uint256 i = _left;
    uint256 j = _right;
    while (i <= j) {
      while (_word[i] < pivot) ++i;
      while (_word[j] > pivot) --j;
      if (_word[i] > pivot || _word[j] < pivot) {
        (_word[i], _word[j]) = (_word[j], _word[i]);
      } else {
        ++i;
      }
    }
    if (j > _left) _quickSort(_word, _left, j - 1);
    _quickSort(_word, j + 1, _right);
  }

  function verifyPath(uint256 _bitboard, uint256 _path, uint256 _length) internal pure {
    uint256 x = ((uint256(7) << 77) & _path) >> 77;
    uint256 y = ((uint256(7) << 74) & _path) >> 74;
    uint256 constructed = 0x8000000000000000 >> (8 * y) >> x;
    for (uint256 i; i < _length - 1; i++) {
      uint256 index = 74 - (3 * (i + 1) );
      uint256 dir = ((uint256(7) << index) & _path) >> index;
      (x, y) = _walk(x, y, dir);
      uint256 next = 0x8000000000000000 >> (8 * y) >> x;
      if (next & constructed == 0) {
        constructed |= next;
      } else {
        revert();
      }
    }
    require(_bitboard == constructed, "INVALID PATH");
  }

  function _toBoxString(uint256 _number) private pure returns (string memory) {
    bytes memory buffer;
    for (uint256 i = 8; i > 0; --i) {
      buffer = abi.encodePacked(buffer, _number & 0x80 != 0 ? unicode"☒" : unicode"☐");
      _number <<= 1;
    }
    return string(buffer);
  }

  function _walk(uint256 _x, uint256 _y, uint256 _dir) private pure returns (uint256 x_, uint256 y_) {
    x_ = _x;
    y_ = _y;
    if (_dir == 0) { // NORTH
      y_--;
    } else if (_dir == 1) { // NORTH EAST
      x_++;
      y_--;
    } else if (_dir == 2) { // EAST
      x_++;
    } else if (_dir == 3) { // SOUTH EAST
      x_++;
      y_++;
    } else if (_dir == 4) { // SOUTH
      y_++;
    } else if (_dir == 5) { // SOUTH WEST
      x_--;
      y_++;
    } else if (_dir == 6) { // WEST
      x_--;
    } else if (_dir == 7) { // NORTH WEST
      x_--;
      y_--;
    }
  }
}