import 'package:flutter/material.dart';
import 'package:gomoku/util/util.dart';
import 'package:gomoku/util/player_enum.dart';

class GameProcessor {
  final int rowNum;
  final int colNum;
  late Player currentPlayer;
  late List<List<Player?>> boardData;

  GameProcessor({required this.rowNum, required this.colNum}) {
    boardData =
        List.generate(rowNum, (i) => List.generate(colNum, (j) => null));
  }

  bool _rowInvalid(int row) {
    return (row < 0 || row >= rowNum);
  }

  bool _colInvalid(int col) {
    return (col < 0 || col >= colNum);
  }

  List<Coordinate> _countStraight(int row, int col, Direction d) {
    if (_colInvalid(col) ||
        _rowInvalid(row) ||
        boardData[row][col] != currentPlayer) {
      return [];
    }

    int deltaRow = 0;
    int deltaCol = 0;
    if (d != Direction.left && d != Direction.right) {
      deltaRow = (d == Direction.up) ? -1 : 1;
      deltaCol = 0;
    }
    if (d != Direction.up && d != Direction.down) {
      deltaCol = (d == Direction.left) ? -1 : 1;
      deltaRow = 0;
    }

    List<Coordinate> recurse =
        _countStraight(row + deltaRow, col + deltaCol, d);

    return recurse + [Coordinate(row, col)];
  }

  List<Coordinate> _countDiagonal(int row, int col, Direction d) {
    if (_colInvalid(col) ||
        _rowInvalid(row) ||
        boardData[row][col] != currentPlayer) {
      return [];
    }

    int deltaRow = 0;
    int deltaCol = 0;
    switch (d) {
      case Direction.upleft:
        deltaRow = deltaCol = -1;
        break;
      case Direction.upright:
        deltaRow = -1;
        deltaCol = 1;
        break;
      case Direction.downleft:
        deltaRow = 1;
        deltaCol = -1;
        break;
      case Direction.downright:
        deltaRow = deltaCol = 1;
        break;
      default:
    }

    List<Coordinate> recurse =
        _countDiagonal(row + deltaRow, col + deltaCol, d);

    return recurse + [Coordinate(row, col)];
  }

  TurnMessenger handleUserMark(int row, int col, Player player) {
    currentPlayer = player;
    boardData[row][col] = player;

    // Check vertical axis
    List<Coordinate> countVertical = _countStraight(row, col, Direction.up) +
        _countStraight(row + 1, col, Direction.down);
    debugPrint("Verical: $countVertical");
    if (countVertical.length >= 5) {
      return TurnMessenger(
        gameFinished: true,
        markedCells: countVertical,
        currentPlayer: player,
      );
    }
    // Check horizontal axis
    List<Coordinate> countHorizontal =
        _countStraight(row, col, Direction.left) +
            _countStraight(row, col + 1, Direction.right);
    debugPrint("Horizontal: $countHorizontal");
    if (countHorizontal.length >= 5) {
      return TurnMessenger(
        gameFinished: true,
        markedCells: countHorizontal,
        currentPlayer: player,
      );
    }
    // Check primary diagonal
    List<Coordinate> countPrimaryDiagonal =
        _countDiagonal(row, col, Direction.upleft) +
            _countDiagonal(row + 1, col + 1, Direction.downright);
    debugPrint("Primary diag: $countPrimaryDiagonal");
    if (countPrimaryDiagonal.length >= 5) {
      return TurnMessenger(
        gameFinished: true,
        markedCells: countPrimaryDiagonal,
        currentPlayer: player,
      );
    }

    // Check secondary diagonal
    List<Coordinate> countScndDiagonal =
        _countDiagonal(row, col, Direction.upright) +
            _countDiagonal(row + 1, col - 1, Direction.downleft);
    debugPrint("Secondary diag: $countScndDiagonal");
    if (countScndDiagonal.length >= 5) {
      return TurnMessenger(
        gameFinished: true,
        markedCells: countScndDiagonal,
        currentPlayer: player,
      );
    }

    return TurnMessenger(
        gameFinished: false, markedCells: null, currentPlayer: player);
  }
}
