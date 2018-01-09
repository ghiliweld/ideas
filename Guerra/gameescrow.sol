pragma solidity 0.4.19;

// @author Ghilia Weldesselasie
// This contract acts and escrow for the card games
// It also tracks and manages the gameEscrow
// Might be split into two contracts later with one inhereting the other


contract GameEscrow {

    event NewGame(address challenger, address challenged, uint timestamp);
    event GameWon(address winner, uint prizeWon, uint timestamp);

    address public gameMaster;

    enum GameWinner { Challenger, Challenged }
    GameWinner public winnerEnum;

    function gameEscrow() public view {
        gameMaster == msg.sender;
    }

    struct Game {
        address challenger;
        address challenged;
        uint pool; // Total pool of funds, what will go to the winner
        address winner;
        // How do I add an enum inside my struct? Not really familiar with enums...
    }

    Game[] public games;

    mapping (uint => address) public gamerNetwork; //Not really necessary but tracks gamers in the network
    mapping (address => uint) public playerWinnings; // Tracks total winnings per individual players

    function playGame(address challenger, address challenged, uint timestamp) public payable {
        NewGame(challenger, challenged, timestamp);
    }

}
