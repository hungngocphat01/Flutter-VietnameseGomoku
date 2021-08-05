import 'package:flutter/material.dart';
import 'util/turn_messenger.dart';
import 'player_enum.dart';

class GameProcessor {
  final int rownum;
  final int colnum;
  late Player current_player;

  List<List<Player?>> boardData = [];

  GameProcessor({required this.rownum, required this.colnum}) {
    boardData = List.generate(
        rownum, (index) => List.generate(colnum, (index) => null));
  }

  bool _rowInvalid(int row) {
    return (row < 0 || row >= rownum);
  }

  bool _colInvalid(int col) {
    return (col < 0 || col >= colnum);
  }

  List<Coordinate> _countVertical(int row, int col, String direction) {
    if (_colInvalid(col) ||
        _rowInvalid(row) ||
        boardData[row][col] != current_player) {
      return [];
    }
    debugPrint("$current_player Counting $direction: $row, $col");
    List<Coordinate>? recurse =
        _countVertical(row + (direction == "up" ? -1 : 1), col, direction);
    return recurse + [Coordinate(row, col)];
  }

  TurnMessenger handleUserMark(int row, int col, Player player) {
    current_player = player;
    boardData[row][col] = player;

    List<Coordinate>? countVertical =
        _countVertical(row, col, "up") + _countVertical(row + 1, col, "down");

    debugPrint("Vertical combo: ${countVertical.length}");
    if (countVertical.length >= 5) {
      return TurnMessenger(
        gameFinished: true,
        markedCells: countVertical,
        currentPlayer: player,
      );
    }

    return TurnMessenger(
        gameFinished: false, markedCells: null, currentPlayer: player);
  }
}
