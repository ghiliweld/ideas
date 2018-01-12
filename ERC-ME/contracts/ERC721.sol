pragma solidity 0.4.19;

// I completely copied this contract from https://github.com/m0t0k1ch1/ERC721-token-sample
// Will be making my own modifications to it soon however

contract ERC721 {
    // Required methods
    function approve(address _to, uint256 _tokenId) external;
    function transfer(address _to, uint256 _tokenId) external;
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function ownerOf(uint256 _tokenId) external view returns (address owner);
    function totalSupply() public view returns (uint256 total);
    function balanceOf(address _owner) public view returns (uint256 balance);


    // Events
    event TransferEvent(address from, address to, uint256 tokenId);
    event Approval(address owner, address approved, uint256 tokenId);

}
