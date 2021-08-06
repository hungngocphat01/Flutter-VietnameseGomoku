import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:gomoku/util/enum.dart';

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

class BoardSize {
  double width = 1;
  double height = 1;

  getWidth() => width.round();
  getHeight() => height.round();
}

class CellStateManager {
  late VoidCallback markThisCell;
  late VoidCallback disableCell;
}
