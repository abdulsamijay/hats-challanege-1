// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import "./Game.sol";
import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Helper is IERC721Receiver, Test {
    Game game;
    uint8 constant DECK_SIZE = 3;
    uint256[DECK_SIZE] deck;

    constructor(address _game) {
        game = Game(_game);
        deck = game.join();
        for (uint8 i; i < DECK_SIZE; i++) {
            game.putUpForSale(deck[i]);
        }
    }

    function swap(uint256 idx) external {
        uint256 monId = deck[idx];
        game.swap(msg.sender, monId, monId);
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
