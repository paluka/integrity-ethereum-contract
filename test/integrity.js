const Integrity = artifacts.require("Integrity");

contract("Integrity", (accounts) => {
  let integrityInstance;

  before(async () => {
    integrityInstance = await Integrity.deployed();
  });

  it("should fail when calling upload from non-owner", async () => {
    const data = "chicken";
    try {
      await integrityInstance.upload.call(accounts[1], data, {
        from: accounts[1],
      });
      assert.fail(
        "should have failed when calling upload from non-owner address"
      );
    } catch (error) {
      assert(true);
    }
  });

  it("should add string data to storage variable on upload when calling from owner", async () => {
    const accountOne = accounts[0];
    const accountTwo = accounts[1];

    const amount = "tree";
    await integrityInstance.upload(accountTwo, amount, {
      from: accountOne,
    });
    const verified = await integrityInstance.verify.call(accountTwo, amount);
    assert.isTrue(verified, "Amount wasn't correctly taken from the sender");
  });
});
