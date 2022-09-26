const { deployDiamond } = require("../scripts/deploy.js");

const { expect } = require("chai");
const toWei = (num) => ethers.utils.parseEther(num.toString());
const fromWei = (num) => ethers.utils.formatEther(num);

describe("DistributorFacetTest", async () => {
  const [contractOwner, partner1, partner2] = await ethers.getSigners();
  beforeEach(async function () {
    diamondAddress = await deployDiamond();
    distributorFacet = await ethers.getContractAt(
      "DistributorFacet",
      diamondAddress
    );
  });

  describe("Initialization", () => {
    it("should update beneficiary addresses correctly", async () => {
      //Check beneficiary addresses
      expect(await distributorFacet.getBeneficiary1()).to.equal(
        partner1.address
      );
      expect(await distributorFacet.getBeneficiary2()).to.equal(
        partner2.address
      );
    });

    it("should update beneficiary stakes correctly", async () => {
      //Check beneficiary stake percentages
      expect(await distributorFacet.getBeneficiary1Stake()).to.equal(70);
      expect(await distributorFacet.getBeneficiary2Stake()).to.equal(30);
    });
  });

  describe("Receival and Distribution", () => {
    it("should receive money and distribute it correctly", async () => {
      const partner1InitialBalance = await partner1.getBalance();
      const partner2InitialBalance = await partner2.getBalance();
      const amountToSend = toWei(10);

      await distributorFacet.receiveAndDistributePayment({
        value: amountToSend,
      });

      const partner1FinalBalance = await partner1.getBalance();
      const partner2FinalBalance = await partner2.getBalance();

      //Check if difference in account balances after recevial and distribution is according to
      //stake percentages.

      expect(
        fromWei(partner1FinalBalance) - fromWei(partner1InitialBalance)
      ).to.equal((fromWei(amountToSend) * 70) / 100);
      expect(
        fromWei(partner2FinalBalance) - fromWei(partner2InitialBalance)
      ).to.equal((fromWei(amountToSend) * 30) / 100);
    });
  });
});
