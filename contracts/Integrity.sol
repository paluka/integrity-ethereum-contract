// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Integrity {
  address public owner;
  string[] data;

  constructor() {
    owner = msg.sender;
  }

  function upload(string calldata _text) restricted external {
    data.push(_text);
  }

  function get() external view returns(string[] memory) {
    return data;
  }

  modifier restricted() {
    require(
      msg.sender == owner,
      "This function is restricted to the contract's owner"
    );
    _;
  }
}
