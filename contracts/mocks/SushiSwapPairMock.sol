// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../uniswapv2/UniswapV2Pair.sol";

contract SushiSwapPairMock is UniswapV2Pair {
    constructor() public UniswapV2Pair() {}
}