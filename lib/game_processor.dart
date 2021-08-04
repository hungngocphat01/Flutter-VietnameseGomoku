import 'package:flutter/material.dart';
import 'util/turn_messenger.dart';
import 'player_enum.dart';

class GameProcessor {
  final int rownum;
  final int colnum;

  List<List<Player?>> boardData = [];

  GameProcessor({required this.rownum, required this.colnum}) {
    boardData = List.filled(rownum, List.filled(colnum, null));
  }

  TurnMessenger handleUserMark(int row, int col, Player player) {
    // TODO: implement game processor
    debugPrint("Game Processor: $player tapped ($row, $col)");
    return TurnMessenger(
        gameFinished: false, markedCells: null, currentPlayer: player);
  }
}
