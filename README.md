# Diamond-Distributor

A sample diamond contract implementation to facilitate transparent money distribution between collaborators.
Complying to EIP-2535 standards.

In today's world there are a lot of collaborations and partnerships. When dividing gains and payments transparency can be a strong issue. This contract can help distribute money/payments to collaborators in
a transparent manner. Although the contract owner is a central entity the addresses and stakes are public
so any change to those will be visible to both partners. This is a very simple implementation, it can be implemented in a better way by extending 2 partners to an indefinite amount of partners with different stakes and can be decentralized by adding governance which reduces malicious attack opportunities. I will continue and update the repo in the future.

The diamond implementation is influenced and based on the diamond-1-reference implementation by Nick Mudge. The changes to check out are facets/DistributorFacet.sol, libraries/LibAssetDistributor.sol, Diamond.sol, deploy.js and test/distributorFacetTest.js.
