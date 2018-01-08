# Guerra

Version 1.0  Last edited on: 08/01/2018

Ghilia Weldesselasie -- <a href='mailto:ghiliaweld@gmail.com'>ghiliaweld@gmail.com</a>

---

*Guerra* (war in Spanish) is a two-player card game/dungeon crawler based on [Donsol](https://hundredrabbits.itch.io/donsol)(it's a really dope game you should check it out).

The game can be played with regular physical cards or online on the web app/Dapp I'll be building. Online, it can be played one of two ways: with no web3 against a CPU or on our Dapp with web3 enabled against other players on the Ethereum Blockchain for the chance to win Ether.

## Rules
Work In Progress

## Design
Minimal UI based heavily on Donsol. Might even fork the [Donsol repo](https://github.com/hundredrabbits/Donsol) on Github if the creators don't mind.

## Web App Gameplay Guide
Work In Progress

## Blockchain Aspect
The Dapp part of the game is very simple. A web3 injection (via Metamask) allows you to interract with a large P2P network of other players on the Guerra network. Each player on the network can either propose a **pitch**(their contribution to the winning pool) and invite other to match their pitch and play against them or they can accept another player's pitch, match it and play against them. Both of their pitches are sent to an Escrow smart contract on the blockchain and once the game is over the pool (the sum of both pitches) is transferred to the winner's wallet. Everything else is done in a centralized manner except for the holding and transferring of funds for UX purposes.
