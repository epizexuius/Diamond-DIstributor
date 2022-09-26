//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {LibDiamond} from "../libraries/LibDiamond.sol";
import {LibAssetDistributor} from "../libraries/LibAssetDistributor.sol";

contract DistributorFacet {
    //Function to enable distribution of ether to collaborators/beneficiaries when this contract receives ether

    //For clean readability can be split up into two functions receive and distribute
    function receiveAndDistributePayment() external payable {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();

        //Access storage variables to get beneficiary addresses and stakes
        address payable _beneficiary1 = ds.beneficiary1;
        address payable _beneficiary2 = ds.beneficiary2;
        uint8 _beneficiary1Stake = ds.beneficiary1Stake;

        //Pay beneficiary1 according to the percentage stake
        uint256 payment1 = (msg.value * _beneficiary1Stake) / 100;
        _beneficiary1.transfer(payment1);

        //The rest of the msg.value is trasnferred to beneficiary2
        _beneficiary2.transfer(msg.value - payment1);
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

    function getBeneficiary1() public view returns (address beneficiary) {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();
        beneficiary = ds.beneficiary1;
        return beneficiary;
    }

    function getBeneficiary2() public view returns (address beneficiary) {
        LibAssetDistributor.DistributorStorage storage ds = LibAssetDistributor.distributorStorage();
        beneficiary = ds.beneficiary2;
        return beneficiary;
    }
}
