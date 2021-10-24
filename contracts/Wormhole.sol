//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./interfaces/IWormhole.sol";


contract Wormhole is IWormhole {    
    address public owner;
    uint public priceGton;
    uint public priceRelic;

    IERC20 public wallet;
    IERC20 public gton;

    constructor (IERC20 _wallet, IERC20 _gton, uint _priceGton, uint _priceRelic) {
        owner = msg.sender;
        wallet = _wallet;
        gton = _gton;
        priceGton = _priceGton;
        priceRelic = _priceRelic;
    }

    modifier isOwner() {
        require(msg.sender == owner, "Only owner allowed.");
        _;
    }

    function setOwner(address _owner) public override isOwner {
        address ownerOld = owner;
        owner = _owner;
        emit SetOwner(ownerOld, _owner);
    }

    function setWallet(IERC20 _wallet) public isOwner {
        address walletOld = address(wallet);
        wallet = _wallet;
        emit SetWallet(walletOld, address(_wallet));
    }

    function setPrice(uint _priceGton, uint _priceRelic) public override isOwner {
        uint priceRelicOld = priceRelic;
        priceGton = _priceGton;
        priceRelic = _priceRelic;
        emit SetPrice(_priceGton, priceRelicOld, _priceRelic);
    }

    function calcAmountOut(uint amount) internal returns (uint) {
        return priceGton / priceRelic * amount;
    }

    function swap(uint amount) public override {
        require(gton.transferFrom(msg.sender, address(this), amount), "Not enought of allowed gton.");
        uint amountOut = calcAmountOut(amount);
        gton.transferFrom(address(wallet), msg.sender, amountOut);
        emit Swap(msg.sender, msg.sender, amount, amountOut);
    }
}