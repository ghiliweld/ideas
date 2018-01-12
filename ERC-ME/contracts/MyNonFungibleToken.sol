pragma solidity 0.4.19;

import "./ERC721.sol";

contract MyNonFungibleToken is ERC721 {
  /*** CONSTANTS ***/

    string public constant NAME = "ERC-ME";
    string public constant SYMBOL = "ME";

    struct Profile {
        string name; // Must be unique
        string handle; // Must be unique
        uint8 followers; // ** Should this be uint8 ?
        uint8 followings; // ** Should this be uint8 ?
        address ownedBy;
        uint64 bornOn;
    }

    Profile[] public profiles;

    mapping (uint256 => address) public profileIndexToOwner;
    mapping (address => uint256) public ownershipProfileCount;
    mapping (uint256 => address) public profileIndexToApproved; // Why is approval a thing, why is this important?

    event Mint(address owner, uint256 profileId);

    function _owns(address _claimant, uint256 _profileId) internal view returns (bool) {
        return profileIndexToOwner[_profileId] == _claimant;
    }

    function _approvedFor(address _claimant, uint256 _profileId) internal view returns (bool) {
        return profileIndexToApproved[_profileId] == _claimant;
    }

    function _approve(address _to, uint256 _profileId) internal {
        profileIndexToApproved[_profileId] = _to;

        Approval(profileIndexToOwner[_profileId], profileIndexToApproved[_profileId], _profileId);
    }

    function _transfer(address _from, address _to, uint256 _profileId) internal {
        ownershipProfileCount[_to]++;
        profileIndexToOwner[_profileId] = _to;

        if (_from != address(0)) {
            ownershipProfileCount[_from]--;
            delete profileIndexToApproved[_profileId];
        }

        Transfer(_from, _to, _profileId);
    }

    function _mint(address _owner, string _name, string _handle) internal returns (uint256 profileId) {
      // ** Should this be changed to storage ?
        Profile memory profile = Profile({
            name: _name,
            handle: _handle,
            followers: 0,
            followings: 0,
            ownedBy: _owner,
            bornOn: uint64(now)
        });
        profileId = profiles.push(profile) - 1;

        Mint(_owner, profileId);

        _transfer(0, _owner, profileId);
    }


    function totalSupply() public view returns (uint256) {
        return profiles.length;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return ownershipProfileCount[_owner];
    }

    function ownerOf(uint256 _profileId) external view returns (address owner) {
        owner = profileIndexToOwner[_profileId];

        require(owner != address(0));
    }

    function approve(address _to, uint256 _profileId) external {
        require(_owns(msg.sender, _profileId));

        _approve(_to, _profileId);
    }

    function transfer(address _to, uint256 _profileId) external {
        require(_to != address(0));
        require(_to != address(this));
        require(_owns(msg.sender, _profileId));

        _transfer(msg.sender, _to, _profileId);
    }

    function transferFrom(address _from, address _to, uint256 _profileId) external {
        require(_to != address(0));
        require(_to != address(this));
        require(_approvedFor(msg.sender, _profileId));
        require(_owns(_from, _profileId));

        _transfer(_from, _to, _profileId);
  }

    function profilesOfOwner(address _owner) external view returns (uint256[]) {
        uint256 balance = balanceOf(_owner);

        if (balance == 0) {
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](balance);
            uint256 maxprofileId = totalSupply();
            uint256 idx = 0;

            uint256 profileId;
            for (profileId = 1; profileId <= maxprofileId; profileId++) {
                if (profileIndexToOwner[profileId] == _owner) {
                    result[idx] = profileId;
                    idx++;
                }
            }
        }

        return result;
    }


  /*** OTHER EXTERNAL FUNCTIONS ***/

    function mint(address owner, string name, string handle) external returns (uint256) {
        return _mint(owner, name, handle);
    }

    function getProfile(uint256 _profileId) external view returns (address ownedBy, uint64 bornOn) {
        // ** Should memory be changed to storage ?
        Profile memory profile = profiles[_profileId];

        ownedBy = profile.ownedBy;
        bornOn = profile.bornOn;
    }
}