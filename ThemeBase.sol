// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import '@openzeppelin/contracts/utils/Strings.sol';

contract ThemeBase {
  using Strings for uint256;

  string internal linebreak_character = '\\n';
  string internal whitespace_character = unicode"　";

  string[] internal COLOR_STRINGS = [
    "Pink",
    "Mint",
    "Sienna",
    "Lilac",
    "Aqua",
    "Marigold",
    "Rose",
    "Cornflower",
    "????"
  ];
  
  string[] internal PLAIN_TEXT = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L",
    "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X",
    "Y", "Z", "?"
  ];

  string[] internal UNICODE_BLOCKS = [
    unicode"🄰", unicode"🄱", unicode"🄲", unicode"🄳", unicode"🄴", unicode"🄵", unicode"🄶", unicode"🄷",
    unicode"🄸", unicode"🄹", unicode"🄺", unicode"🄻", unicode"🄼", unicode"🄽", unicode"🄾", unicode"🄿",
    unicode"🅀", unicode"🅁", unicode"🅂", unicode"🅃", unicode"🅄", unicode"🅅", unicode"🅆", unicode"🅇",
    unicode"🅈", unicode"🅉", unicode"�"
  ];

  string[2][] internal SVG_COLORS = [
    // PINK
    ['FC00A7', '81008E'],
    // MINT
    ['3EB489', '256E54'],
    // SIENNA
    ['F87F00', 'AA0000'],
    // LILAC
    ['EE5BFF', '4C30A6'],
    // AQUA
    ['3CDCD0', '138686'],
    // MARIGOLD
    ['FFE211', 'ECA51E'],
    // ROSE
    ['EB004C', '820E1D'],
    // CORNFLOWER
    ['6195ED', '3E468E'],
    // B&W
    ['FFFFFF', '000000']
  ];

  string[2][] internal SVG_SHAPES = [
    // A
    [
      'M40 30v15h-5V30h5Zm-20 0v15h-5V30h5Zm20-10v10H25v-5h10v-5h5Zm-20 0v5h5v5H15V20h5Zm20-5v5h-5v-5h5Zm-20 0v5h-5v-5h5Zm15-5v5H25v-5h10Zm-10 0v5h-5v-5h5Z',
      'M5 55h50V5H5v50Zm40-40v35H35v-5h5V15h5ZM35 30v5H25v15H15v-5h5V30h15Zm0-15v5H25v5h-5V15h15Zm5-5v5h-5v-5h5ZM0 0h60v60H0V0Z'
    ],
    // B
    [
      'M20 20v5h15v5H20v10h15v5H15V20h5Zm20 10v10h-5V30h5Zm0-10v5h-5v-5h5Zm-5-10v5h5v5h-5v-5H20v5h-5V10h20Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM45 30v15h-5v5H15v-5h20v-5h5V30h5Zm-10 0v5H25v5h-5V30h15Zm5-5v5h-5v-5h5Zm5-10v10h-5V15h5Zm-25 0h15v5H25v5h-5V15Zm20-5v5h-5v-5h5Z'
    ],
    // C
    [
      'M35 40v5H20v-5h15Zm5-10v10h-5V30h5ZM20 20v20h-5V20h5Zm20-5v5h-5v-5h5Zm-20 5h-5v-5h5v-5h15v5H20v5Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM15 45v-5h5v5h15v-5h5V30h5v15h-5v5H20v-5h-5Zm20-30v5H25v20h-5V15h15Zm10 0v10H35v-5h5v-5h5Zm-5-5v5h-5v-5h5Z'
    ],
    // D
    [
      'M20 20v20h10v5H15V20h5Zm15 15v5h-5v-5h5Zm5-15v15h-5V20h5Zm-5-5v5h-5v-5h5Zm-5-5v5H20v5h-5V10h15Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM35 45v5H15v-5h20Zm5-30v5h5v20h-5v5H30v-5h5v-5h5V20h-5v-5h5Zm-20 0h10v-5h5v5h-5v5h-5v20h-5V15Z'
    ],
    // E
    [
      'M20 20v5h15v5H20v10h20v5H15V20h5Zm20-10v5H20v5h-5V10h25Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM45 40v10H15v-5h25v-5h5Zm-5-15v10H25v5h-5V30h15v-5h5ZM20 15h20v-5h5v10H25v5h-5V15Z'
    ],
    // F
    [
      'M20 35v10h-5V35h5Zm0-15v5h15v5H20v5h-5V20h5Zm-5-10h25v5H20v5h-5V10Z',
      'M15 0v5H5v50h10v5H0V0h15Zm25 55v5H15v-5h25ZM60 0v60H40v-5h15V5H40V0h20ZM40 25v10H25v15H15v-5h5V30h15v-5h5ZM20 15h20v5H25v5h-5V15Zm25-5v10h-5V10h5ZM40 0v5H15V0h25Z'
    ],
    // G
    [
      'M35 40v5H25v-5h10Zm-10 0v5h-5v-5h5Zm15-15v15h-5V30h-5v-5h10Zm-20-5v20h-5V20h5Zm15-10v5h5v5h-5v-5H25v-5h10ZM20 20h-5v-5h5v-5h5v5h-5v5Z',
      'M60 35v25H45v-5h10V35h5ZM45 55v5H25v-5h20ZM5 35v20h20v5H0V35h5Zm40 0v10h-5v5H25v-5h10v-5h5v-5h5ZM25 45v5h-5v-5h5Zm0-10v5h-5v5h-5v-5h5v-5h5Zm35-25v25h-5V10h5ZM45 25v10h-5V25h5Zm-10 5v5h-5v-5h5ZM25 15v20h-5V15h5ZM5 10v25H0V10h5Zm35 0v5h5v5h-5v-5h-5v5H25v-5h10v-5h5ZM60 0v10h-5V5H45V0h15ZM0 0h25v5H5v5H0V0Zm45 0v5H25V0h20Z'
    ],
    // H
    [
      'M40 20v25h-5V30h-5v-5h5v-5h5Zm-20 0v5h10v5H20v15h-5V20h5Zm20-10v10h-5V10h5ZM20 20h-5V10h5v10Z',
      'M60 0v60h-5V0h5Zm-5 55v5H30v-5h25Zm-25 0v5H5v-5h25ZM0 0h5v60H0V0Zm45 10v40H35v-5h5V10h5ZM30 30v5h-5v15H15v-5h5V30h10Zm5 0v5h-5v-5h5ZM25 10v15h-5V10h5ZM55 0v5H30V0h25ZM30 0v5H5V0h25Z'
    ],
    // I
    [
      'M30 20v20h10v5H25V20h5Zm-5 20v5H15v-5h10Zm15-30v5H30v5h-5V10h15Zm-25 5v-5h10v5H15Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM45 40v10H15v-5h25v-5h5Zm0-30v10H35v20h-5V15h10v-5h5ZM15 20v-5h10v5H15Z'
    ],
    // J
    [
      'M35 40v5H20v-5h15Zm5-20v20h-5V20h5ZM15 30h5v10h-5V30Zm25-20v10h-5V10h5Z',
      'M60 0v60H15v-5h40V5H15V0h45ZM15 0v5H5v50h10v5H0V0h15Zm30 10v35h-5v5H20v-5h15v-5h5V10h5ZM20 40v5h-5v-5h5Zm5-10v10h-5V30h5Z'
    ],
    // K
    [
      'M40 35v10h-5V35h5ZM20 20v5h5v-5h5v10h5v5h-5v-5H20v15h-5V20h5Zm15-5v5h-5v-5h5Zm-20-5h5v10h-5V10Zm25 0v5h-5v-5h5Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM40 30v5h5v15H35v-5h5V35h-5v-5h5Zm-10 0v5h-5v15H15v-5h5V30h10Zm5-10v10h-5V20h5ZM20 10h5v15h-5V10Zm20 5v5h-5v-5h5Zm5-5v5h-5v-5h5Z'
    ],
    // L
    [
      'M20 20v20h20v5H15V20h5Zm-5-10h5v10h-5V10Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM45 40v10H15v-5h25v-5h5ZM20 10h5v30h-5V10Z'
    ],
    // M
    [
      'M40 20v25h-5V25h-5v5h-5v-5h-5v20h-5V20h25Zm0-10v10H30v-5h5v-5h5Zm-25 0h5v5h5v5H15V10Z',
      'M40 55v5H15v-5h25ZM60 0v60H40v-5h15V5H40V0h20ZM15 0v5H5v50h10v5H0V0h15Zm25 45v5h-5v-5h5ZM25 25v5h5v-5h5v10H25v15H15v-5h5V25h5Zm20-15v40h-5V10h5Zm-15 5v5h-5v-5h5Zm-5-5v5h-5v-5h5ZM40 0v5H15V0h25Z'
    ],
    // N
    [
      'M40 20v25h-5V35h-5v-5h-5v-5h5v5h5V20h5Zm-15 0v5h-5v20h-5V20h10Zm15-10v10h-5V10h5Zm-25 0h5v10h-5V10Z',
      'M40 55v5H25v-5h15ZM25 0v5H5v50h20v5H0V0h25Zm35 0v60H45v-5h10V5H45V0h15ZM45 55v5h-5v-5h5Zm-5-10v5h-5v-5h5ZM25 25v25H15v-5h5V25h5Zm20-15v40h-5V10h5ZM30 20v5h5v5h-5v5h5v5h-5v-5h-5v-5h5v-5h-5v-5h5ZM20 10h5v10h-5V10ZM45 0v5H25V0h20Z'
    ],
    // O
    [
      'M40 20v20h-5v5h-5v-5h5V20h5Zm-20 0v20h10v5H20v-5h-5V20h5Zm15-10v5h5v5h-5v-5h-5v-5h5Zm-15 5v-5h10v5H20v5h-5v-5h5Z',
      'M5 0v60H0V0h5Zm25 55v5H5v-5h25ZM60 0v60h-5V0h5Zm-5 55v5H30v-5h25ZM45 15v30h-5v5H30v-5h5v-5h5V15h5ZM30 45v5H20v-5h10Zm-10-5v5h-5v-5h5Zm10-25v5h-5v20h-5V15h10Zm10-5v5h-5v5h-5v-5h5v-5h5ZM55 0v5H30V0h25ZM30 0v5H5V0h25Z'
    ],
    // P
    [
      'M15 10h20v5H20v10h15V15h5v15H20v15h-5V10Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM40 30v5H25v15H15v-5h5V30h20Zm5-15v15h-5V15h5Zm-25 0h15v5H25v5h-5V15Zm20-5v5h-5v-5h5Z'
    ],
    // Q
    [
      'M40 15v25h5v5H35v-5h-5v5H20v-5h10v-5h5V15h5Zm-25 0h5v25h-5V15Zm15 15v5h-5v-5h5Zm5-20v5H20v-5h15Z',
      'M45 0v5H5v50h50V5H45V0h15v60H0V0h45ZM35 40v5h10v5H20v-5h10v-5h5Zm-15 0v5h-5v-5h5Zm25-25v25h-5V15h5Zm-10 0v5H25v20h-5V15h15Zm0 15v5h-5v-5h5Zm5-20v5h-5v-5h5Z'
    ],
    // R
    [
      'M40 40v5h-5v-5h5ZM15 10h20v5H20v10h15v5h-5v5h-5v-5h-5v15h-5V10Zm20 25v5h-5v-5h5Zm5-20v10h-5V15h5Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM40 35v5h5v10H35v-5h5v-5h-5v-5h5Zm-15-5v20H15v-5h5V30h5Zm15-5v5h-5v5h-5v-5h5v-5h5Zm5-10v10h-5V15h5Zm-25 0h15v5H25v5h-5V15Zm20-5v5h-5v-5h5Z'
    ],
    // S
    [
      'M35 40v5H20v-5h15Zm5-10v10h-5V30h5Zm-20 5v5h-5v-5h5Zm15-10v5H20v-5h15ZM15 15h5v10h-5V15Zm25 0v5h-5v-5h5Zm-5-5v5H20v-5h15Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5ZM35 45v-5h5V30h5v15h-5v5H20v-5h15Zm-15-5v5h-5v-5h5Zm15-10v5H20v-5h15Zm5-5v5h-5v-5h5Zm-20 0v5h-5v-5h5Zm15-10v5H25v5h-5V15h15Zm10 0v5h-5v-5h5Zm-5-5v5h-5v-5h5Z'
    ],
    // T
    [
      'M15 15v-5h25v5H30v30h-5V15H15Z',
      'M40 55v5H15v-5h25ZM60 0v60H40v-5h15V5H40V0h20ZM15 0v5H5v50h10v5H0V0h15Zm10 50v-5h5V15h10v5h-5v30H25Zm20-40v10h-5V10h5Zm-20 5v5H15v-5h10ZM40 0v5H15V0h25Z'
    ],
    // U
    [
      'M35 40v5H25v-5h10Zm-10 0v5h-5v-5h5Zm15-30v30h-5V10h5Zm-25 0h5v30h-5V10Z',
      'M60 0v60H45v-5h10V5H45V0h15ZM45 55v5h-5v-5h5ZM25 0v5H5v50h20v5H0V0h25Zm15 55v5H25v-5h15Zm0-15v10H25v-5h10v-5h5Zm-15 5v5h-5v-5h5Zm20-35v35h-5V10h5ZM20 40v5h-5v-5h5Zm5-30v30h-5V10h5ZM45 0v5H25V0h20Z'
    ],
    // V
    [
      'M15 10h5v20h5v5h5v10h-5v-5h-5V30h-5V10Zm25 0v20h-5v10h-5V30h5V10h5Z',
      'M60 0v60h-5V0h5Zm-5 55v5H30v-5h25Zm-25 0v5H5v-5h25ZM5 0v60H0V0h5Zm35 30v10h-5v10h-5V40h5V30h5ZM30 45v5h-5v-5h5Zm-5-5v5h-5v-5h5Zm-5-10v5h-5v-5h5Zm25-20v20h-5V10h5Zm-20 0v20h-5V10h5ZM55 0v5H30V0h25ZM30 0v5H5V0h25Z'
    ],
    // W
    [
      'M35 40v5h-5v-5h5Zm-10 0v5h-5v-5h5Zm15-30v30h-5V10h5Zm-10 5v25h-5V15h5Zm-15-5h5v30h-5V10Z',
      'M60 0v60H0V0h60Zm-5 5H5v50h50V5Zm-10 5v35h-5v5H30v-5h5v-5h5V10h5ZM25 45v5h-5v-5h5Zm5-5v5h-5v-5h5Zm-10 0v5h-5v-5h5Zm15-25v25h-5V15h5Zm-10 0v25h-5V15h5Zm0-5v5h-5v-5h5Z'
    ],
    // X
    [
      'M40 40v5h-5v-5h5Zm-20 0v5h-5v-5h5Zm15-10v5h5v5h-5v-5h-5v-5h5Zm-15 5v5h-5v-5h5Zm10-10v5h-5v5h-5v-5h5v-5h5Zm10-15v10h-5v5h-5v-5h5V10h5Zm-25 0h5v10h5v5h-5v-5h-5V10Z',
      'M60 0v60H0V0h60ZM5 5v50h50V5H5Zm40 5v15H35h5v10h5v15H35v-5h5V35h-5v-5h-5v5h-5v-5h5v-5h5v-5h5V10h5ZM25 35v15H15v-5h5V35h5Zm5-15v5h-5v-5h5ZM20 10h5v10h-5V10Z'
    ],
    // Y
    [
      'M30 40v5h-5v-5h5Zm0-15v15h-5V25h5Zm5-5v5h-5v-5h5Zm-10 0v5h-5v-5h5Zm15-10v10h-5V10h5Zm-25 0h5v10h-5V10Z',
      'M0 0h60v60H0V0Zm55 5H5v50h50V5ZM40 20v10h-5v20H25v-5h5V25h5v-5h5Zm-15 5v5h-5v-5h5Zm5-5v5h-5v-5h5Zm15-10v10h-5V10h5Zm-20 0v10h-5V10h5Z'
    ],
    // Z
    [
      'M40 40v5H15v-5h25ZM25 30v5h-5v5h-5v-5h5v-5h5Zm5-5v5h-5v-5h5Zm5-5v5h-5v-5h5Zm-20-5v-5h25v10h-5v-5H15Z',
      'M0 0h60v60H0V0Zm55 5H5v50h50V5ZM45 40v10H15v-5h25v-5h5Zm-20-5v5h-5v-5h5Zm5-5v5h-5v-5h5Zm5-5v5h-5v-5h5Zm5-5v5h-5v-5h5Zm5-10v10h-5V10h5Zm-10 5v5H15v-5h20Z'
    ],
    // ?
    [
      'M25 40v5h-5v-5h5Zm15-30v15h-5v5h-5v5h-5v-5h5V20h5v-5H25v-5h15Zm-25 0h10v5h-5v10h-5V10Z',
      'M60 0v60H45v-5h10V5H45V0h15ZM45 55v5H25v-5h20ZM0 0h25v5H5v50h20v5H0V0Zm30 40v10h-5V40h5Zm-5 5v5h-5v-5h5Zm10-15v5h-5v-5h5Zm5-5v5h-5v-5h5Zm-20 0v5h-5v-5h5Zm25-15v15h-5V10h5Zm-20 5v10h-5V15h5Zm10 0v5H25v-5h10ZM45 0v5H25V0h20Z'
    ]
  ];

  function _getColorString(
    uint256 _colorIndex
  ) internal virtual view returns (string memory colorString_) {
    if (_colorIndex < COLOR_STRINGS.length) {
      return COLOR_STRINGS[_colorIndex];
    } else {
      return COLOR_STRINGS[COLOR_STRINGS.length - 1];
    }
  }
  
  function _getLetterBlock(
    uint256 _letterBlockData,
    uint256 _index
  ) internal pure returns (uint256) {
    return uint8(bytes24(uint192(_letterBlockData))[_index]);
  }

  function _getLetterParts(
    uint256 _letterIndex
  ) internal virtual view returns (string memory lightParts_, string memory darkParts_) {
    if (_letterIndex < SVG_SHAPES.length) {
      return (SVG_SHAPES[_letterIndex][0], SVG_SHAPES[_letterIndex][1]);
    } else {
      return (
        SVG_SHAPES[SVG_SHAPES.length - 1][0],
        SVG_SHAPES[SVG_SHAPES.length - 1][1]
      );
    }
  }

  function _getSvgColors(
    uint256 _colorIndex
  ) internal virtual view returns (string memory primaryColor_, string memory secondaryColor_) {
    if (_colorIndex < SVG_COLORS.length) {
      return (SVG_COLORS[_colorIndex][0], SVG_COLORS[_colorIndex][1]);
    } else {
      return (SVG_COLORS[SVG_COLORS.length-1][0], SVG_COLORS[SVG_COLORS.length-1][1]);
    }
  }
  
  function _getUnicodeBlock(
    uint256 _letterIndex
  ) internal virtual view returns (string memory renderedLetter_) {
    if (_letterIndex < UNICODE_BLOCKS.length) {
      return UNICODE_BLOCKS[_letterIndex];
    } else {
      return UNICODE_BLOCKS[UNICODE_BLOCKS.length-1];
    }
  }
  
  function _renderColorDescription(uint256 _colorBitfield) internal view returns (string memory) {
    bytes memory colorString;
    string memory and;
    for(uint256 i; i < 8; i++) {
      if(_colorBitfield & (2 ** i) != 0) {
        colorString = abi.encodePacked(_getColorString(i), and, colorString);
        and = bytes(and).length != 0 ? ", " : " & ";
      }
    }
    return string(colorString);
  }

  function _renderLetterBlock(
    uint256 _x,
    uint256 _y,
    uint256 _char
  ) internal virtual view returns (string memory renderedLetter_) {
    uint256 letterIndex = _char >> 3;
    uint256 colorIndex = _char & 0x7;
    (string memory primaryColor, string memory secondaryColor) = _getSvgColors(colorIndex);
    (string memory lightParts, string memory darkParts) = _getLetterParts(letterIndex);
    return string(
      abi.encodePacked(
        '<g transform="translate(',(_x * 60).toString(),' ',(_y * 60).toString(),')">',
          '<path fill="#',primaryColor,'" d="',lightParts,'"/>',
          '<path fill="#',secondaryColor,'" d="',darkParts,'"/>',
        '</g>'
      )
    );
  }

  function _renderSvg(uint256 _shape, uint256 _letterBlocks, uint256 _length) internal virtual view returns (string memory svg_) {
    bytes memory letters;

    uint256 j;
    uint256 x;
    uint256 y;
    uint256 width;

    for (uint256 i;i<64;i++) {
      if (_shape & (1 << (63 - i)) != 0) {
        if (x > width) {
          width = x;
        }
        letters = abi.encodePacked(letters, _renderLetterBlock(x, y, _getLetterBlock(_letterBlocks, j)));
        if (j == _length - 1) {
          break;
        }
        j++;
      }
      x++;
      if (x == 8) {
        x = 0;
        y++;
      }
    }

    return string(
      abi.encodePacked(
        '<svg '
          'xmlns="http://www.w3.org/2000/svg" '
          'viewBox="0 0 ', ((width + 1) * 60).toString(), ' ', ((y + 1) * 60).toString(),'"'
        '>',
          letters,
        '</svg>'
      )
    );
  }
  
  function _renderUnicode(uint256 _shape, uint256 _letterBlocks, uint256 _length) internal virtual view returns (string memory unicode_) {
    bytes memory letters;
    uint256 j;

    for (uint256 i;i<64;i++) {
      if (_shape & (1 << (63 - i)) != 0) {
        letters = abi.encodePacked(
          letters,
          _getUnicodeBlock(
            uint8(
              _getLetterBlock(_letterBlocks, uint8(j))
            ) >> 3
          )
        );
        if (j == _length - 1) {
          break;
        }
        j++;
      } else {
        letters = abi.encodePacked(letters, whitespace_character);
      }
      
      if (i != 0 && i % 8 == 7) {
        letters = abi.encodePacked(letters, linebreak_character);
      }
    }

    return string(letters);
  }
}