// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract YieldFarmer { // first nura yield farm test 
    Icomptroller comptroller;
    IcToken cDai; 
    IERC20 dai;
    uint borrowFactor = 70; // go with 70 vs. 75 to keep a small profit

    constructor(
        address comptrollerAddress,
        address cDaiAddress,
        address daiAddress
    ) public {
        comptroller = Icomptroller(comptrollerAddress);
        cDai = Ictoken(cDaiAddress);
        dai = IERC20(daiAddress);
        address[] memory cTokens = new address[(1)];
        cTokens[0] = cDaiAddress; 
        comptroller.enterMarkets(cTokens);
    }
    function openPosition(uint initialAmount) external {
        uint nextCollaterelAmount = initialAmount;
        for(uint i = 0; i < 6; i++) { //expecting a full cycle 6 times
            nextCollateralAmount = _SupplyAndBorrow(nextCollateralAmount);
         }
    }

    function _supplyAndBorrow(uint collateralAmount) internal returns(uint) {
        dai.approve(address(cDai), collateralAmount);
        cDai.mint(collateralAmount); //transfer
        uint borrowAmount = (collateralAmount * 70) /100;
        cDai.borrow(borrowAmount);
        return borrowAmount;
    }

    function closePosition() external {
        //function closes and reivests returns.
        uint balanceBorrow = cDai.borrowBalanceCurrent(address(this));
        dai.approve(address(cDai), balanceBorrow);
        cDai.repayBorrow(balanceBorrow); //compound should deliver token
        uint balancecDai = cDai.balanceOf (address(this));
        cDai.redeem(balancecDai);
        
        //needs to be finished after we build iComproller smart contract
    }
}
