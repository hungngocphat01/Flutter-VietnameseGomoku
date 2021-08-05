import 'package:tuple/tuple.dart';
import 'package:gomoku/util/player_enum.dart';

class TurnMessenger {
  bool gameFinished;
  List<Tuple2<int, int>>? markedCells;
  Player currentPlayer;

  TurnMessenger({
    required this.gameFinished,
    required this.markedCells,
    required this.currentPlayer,
  });
}
