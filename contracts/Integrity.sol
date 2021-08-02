// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Integrity {
  address public owner;
  mapping (address => string) private data;

  constructor() public {
    owner = msg.sender;
  }

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }

  function upload(address dataOwner, string calldata _text) restricted external returns(bool) {
		data[dataOwner] = _text;
		return true;
	}

	function verify(address dataOwner, string memory _text) public view returns(bool) {
		return keccak256(bytes(data[dataOwner])) == keccak256(bytes(_text));
	}
}
