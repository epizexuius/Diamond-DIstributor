//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {LibAssetDistributor} from "../libraries/LibAssetDistributor.sol";

contract DistributorFacet {
    //event PaymentDistributed(address beneficiary1, uint256 amount1, address beneficiary2, uint256 amount2);

    //Function to enable distribution of ether when this contract receives ether

    //For clean readability can be split up into two functions receive and distribute
    function receiveAndDistributePayment() external payable {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();

        //Access storage variables to get beneficiary addresses and stakes
        address payable _beneficiary1 = ds.beneficiary1;
        address payable _beneficiary2 = ds.beneficiary2;
        uint8 _beneficiary1Stake = ds.beneficiary1Stake;

        uint256 payment1 = (msg.value * _beneficiary1Stake) / 100;
        _beneficiary1.transfer(payment1);
        _beneficiary2.transfer(msg.value - payment1);
        //emit PaymentDistributed(_beneficiary1, payment1, _beneficiary2, msg.value - payment1);
    }

    function getBeneficiary1Stake() public view returns (uint8 stake) {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();
        stake = ds.beneficiary1Stake;
        return stake;
    }

    function getBeneficiary2Stake() public view returns (uint8 stake) {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();
        stake = ds.beneficiary2Stake;
        return stake;
    }
}
