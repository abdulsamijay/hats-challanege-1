// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.12;

import "forge-std/Test.sol";
import "../Game.sol";
import "../CTF.sol";
import "../Helper.sol";

contract ContractTest is Test {
    Helper helper1;
    Helper helper2;
    CTF ctf;
    Game game;

    function setUp() public {}

    function test() public {
        // ------------- Deploy Game --------------------------------
        vm.startPrank(address(0x1337));
        game = new Game();
        console.log("Initial Flag Holder", game.flagHolder());

        // ------------- Deploy Helper & CTF Contract ---------
        helper1 = new Helper(address(game));
        helper2 = new Helper(address(game));
        ctf = new CTF(address(game), address(helper1), address(helper2));
        vm.stopPrank();

        // ------------- Run Attack function ------------------------
        console.log("(CTF) address", address(ctf));
        console.log("Attacking !!!");
        ctf.attack();
        console.log("Final FlagHolder => (CTF) address", game.flagHolder());
    }
}
