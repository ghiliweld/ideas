pragma solidity 0.4.19;

import "./MyNonFungibleToken.sol";


contract ERCME is MyNonFungibleToken {
    // ** Do I need a contant variable for my zero, compiler thingy

    address public controller = 0xcfde; // The controller of the contract aka me **not my real address must be changed

    event NewFollow(uint256 followingId, uint256 followedId);
    event NewUnfollow(uint256 unfollowingId, uint256 unfollowedId);
    event NameChange(uint256 profileId, string newName);
    event HandleChange(uint256 profileId, string newHandle);

    function _checkUniqueName(string _name) internal view returns(bool) {
        // Loops through our profiles array to check if the name we want to use is already taken
        for (uint i = 0; i <= profiles.length; i++) {
            if (_name == profiles[i].name) {
                return false;
            }
        }
        return true;
    }

    function _checkUniqueHandle(string _handle) internal view returns(bool) {
        // Loops through our profiles array to check if the handle we want to use is already taken
        for (uint i = 0; i <= profiles.length; i++) {
            if (_handle == profiles[i].handle) {
                return false;
            }
        }
        return true;
    }

    function _acceptAndWithdraw(uint _donation) internal {
        require(_donation == 0);
        controller.transfer(_donation);
        /* Profiles are free to create (except for the gas fee),
        but I want to be able to accept donations to the contract.
        Meaning that if someone choose to send some ETH my way, I want to be able to accept it.
         ** Is it possible to accept payments but for it not to be a mandatory part of the operation?
        i.e. Will the createProfile function still run if ETH is not sent to it ? */
    }

    function createProfile(string name, string handle) external payable {
        require(_checkUniqueName(name));
        require(_checkUniqueHandle(handle));

        // Donation logic
        _acceptAndWithdraw(msg.value);

        // Mint the profile
        _mint(msg.sender, name, handle);
    }

    function newFollow(uint8 followIncrease, uint256 initiatorId, uint256 targetId) external {
        /* Triggered when somebody follows another person
        followIncrease is used when deferred updating is enabled
        A following is added to the initiator and a follower is added to the target
        ** Needs to be further optimized for gas efficiency
        A for loop is necessary if you want each NewFollow event to be triggered for a new following */

        require(_owns(msg.sender, initiatorId));
        uint8 memory increase = followIncrease;
        for (uint memory i = 1; i <= increase; i++) {
            profiles[initiatorId].followings++;
            profiles[targetId].followers++;
            NewFollow(initiatorId, targetId);
        }
    }

    function newUnfollow(uint8 followDecrease, uint256 initiatorId, uint256 targetId) external {
        /* Triggered when somebody unfollows another person
        followDecrease is used when deferred updating is enabled
        A following is substracted from the initiator and a follower is substracted from the target
        ** Needs to be further optimized for gas efficiency
        A for loop is necessary if you want each NewUnfollow event to be triggered for a new unfollowing */

        require(_owns(msg.sender, initiatorId));
        uint8 memory decrease = followDecrease;
        for (uint memory i = 1; i <= decrease; i++) {
            profiles[initiatorId].followings--;
            profiles[targetId].followers--;
            NewUnfollow(initiatorId, targetId);
        }
    }

    function changeName(string newName, uint256 profileId) external {
        require(_owns(msg.sender, profileId));
        require(_checkUniqueName(newName));
        profiles[profileId].name = newName;
        NameChange(profileId, newName);
    }

    function changeHandle(string newHandle, uint256 profileId) external {
        require(_owns(msg.sender, profileId));
        require(_checkUniqueHandle(newHandle));
        profiles[profileId].handle = newHandle;
        HandleChange(profileId, newHandle);
    }

}
