// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "../uniswapv2/UniswapV2Factory.sol";

contract SushiSwapFactoryMock is UniswapV2Factory {
    constructor(address _feeToSetter) public UniswapV2Factory(_feeToSetter) {}
}