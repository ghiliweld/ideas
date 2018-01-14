pragma solidity 0.4.19;

// @author Ghilia Weldesselasie
// This contract acts as an escrow for the card games
// It also tracks and manages the games
// Might be split into two contracts later with one inheriting the other

contract GameEscrow {

    event NewGame(address challenger, address challenged, uint timestamp, uint pool);
    event GameWon(address winner, uint prizeWon, uint timestamp);

    address public gameMaster; // aka me, the one who controls the whole game

    enum GameWinner { Challenger, Challenged }

    // Constructor function
    function GameEscrow() public view {
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

    function challengerPitch(address challenger) public payable {
        challenger = msg.sender;
        challengerPitch = msg.value;
    }

    function playGame(address challenger, address challenged) public payable {
        mapping (address => uint) public memory playerPitches; // map of pitches by players
        // I don't know how to accept payements from two addresses
        // Will figure out how to solve this

        NewGame(challenger, challenged, timestamp, pool);
    }

}
