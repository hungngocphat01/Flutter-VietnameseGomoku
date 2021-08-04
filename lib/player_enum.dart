enum Player { player1, player2 }

Player playerNegate(Player p) =>
    p == Player.player1 ? Player.player2 : Player.player1;
