// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibAssetDistributor {
    bytes32 constant DISTRIBUTOR_STORAGE_POSITION = keccak256("distributor_storage_position");

    /**@notice For 2 benficiaries we only need one variable to keep track of both stakes
        x and (100 - x) but for simplicity right now this optimization has been foregone 
        considering that I plan to implement it for any amount of beneficiaries 
        and respective stakes that can be updated using another DiamondFacet. 
        The uint256 has however been converted to uint8 for better struct packing.*/

    struct DistributorStorage {
        uint8 beneficiary1Stake;
        uint8 beneficiary2Stake;
        address payable beneficiary1;
        address payable beneficiary2;
    }

    function setBeneficiariesAndStakes(
        address _beneficiary1,
        address _beneficiary2,
        uint8 _beneficiary1Stake,
        uint8 _beneficiary2Stake
    ) internal {
        DistributorStorage storage ds = distributorStorage();
        ds.beneficiary1 = payable(_beneficiary1);
        ds.beneficiary2 = payable(_beneficiary2);
        ds.beneficiary1Stake = _beneficiary1Stake;
        ds.beneficiary2Stake = _beneficiary2Stake;
    }

    function distributorStorage() internal pure returns (DistributorStorage storage ds) {
        bytes32 position = DISTRIBUTOR_STORAGE_POSITION;
        assembly {
            ds.slot := position
        }
    }
}
