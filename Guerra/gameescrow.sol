pragma solidity 0.4.19;

// @author Ghilia Weldesselasie
// This contract acts as an escrow for the card games
// It also tracks and manages the games
// Might be split into two contracts later with one inheriting the other

contract GameEscrow {

    event NewGame(address challenger, address challenged, uint timestamp);
    event GameWon(address winner, uint prizeWon, uint timestamp);

    address public gameMaster; // aka me, the one who controls the whole game

    enum GameWinner { Challenger, Challenged }

    function gameEscrow() public view {
        gameMaster == msg.sender;
    }

    struct Game {
        address challenger;
        address challenged;
        uint pool; // Total pool of funds, what will go to the winner
        GameWinner winner; // winner is an enum that can either correspond to the challenger or challenged
    }

    Game[] public games; // an array of all Games that includes our Game struct

    mapping (uint => address) public gamerNetwork; //Not really necessary but tracks gamers in the network
    mapping (address => uint) public playerWinnings; // Tracks total winnings per individual players

    function playGame(address challenger, address challenged, uint timestamp) public payable {
        NewGame(challenger, challenged, timestamp);
    }

}
