import 'package:tuple/tuple.dart';

enum Player { player1, player2 }
typedef Coordinate = Tuple2<int, int>;

Player playerNegate(Player p) =>
    p == Player.player1 ? Player.player2 : Player.player1;

enum Direction { left, right, up, down, upleft, upright, downleft, downright }
