pragma solidity 0.4.19;

import "./MyNonFungibleToken.sol";


contract ERCME is MyNonFungibleToken {

    function checkUniqueName(string name) internal view returns(bool) {
      // Loops through our profiles array to check if the name we want to use is already taken
    }

    function checkUniqueHandle(string name) internal view returns(bool) {
      // Loops through our profiles array to check if the handle we want to use is already taken
    }

    function createProfile(address owner, string name, string handle) external {
        require(checkUniqueName(name));
        require(checkUniqueName(handle));

        mint(msg.sender, name, handle);
    }

}
