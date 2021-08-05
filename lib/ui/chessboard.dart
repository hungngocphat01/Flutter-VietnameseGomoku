import 'package:flutter/material.dart';
import 'chessboard_cell.dart';
import 'package:gomoku/player_enum.dart';
import 'package:gomoku/util/turn_messenger.dart';
import 'package:gomoku/game_processor.dart';

class Chessboard extends StatefulWidget {
  const Chessboard({Key? key}) : super(key: key);

  static _ChessboardState? of(BuildContext context) {
    assert(context != null);
    final _ChessboardState? result =
        context.findAncestorStateOfType<_ChessboardState>();
    return result;
  }

  @override
  _ChessboardState createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  late int rownum;
  late int colnum;
  late GameProcessor processor;
  late Player currentPlayer;
  late List<Row> boardRows;
  late BuildContext _context;

  _ChessboardState() : super() {
    rownum = 5;
    colnum = 5;
    processor = GameProcessor(rownum: rownum, colnum: colnum);
    currentPlayer = Player.player1;
  }

  Player handleUserClick(int row, int col) {
    // Send data to processor
    TurnMessenger messenger = processor.handleUserMark(row, col, currentPlayer);
    // If game finished (either player has won)
    if (messenger.gameFinished) {
      debugPrint("Game end");
      debugPrint("Victory: ${messenger.currentPlayer}");
      // Mark combo cells
      messenger.markedCells?.forEach((c) {
        (boardRows[c.item1].children[c.item2] as ChessboardCell)
            .isMarked
            .value = true;
      });
      // Disable input
      for (Row row in boardRows) {
        for (Widget c in row.children) {
          (c as ChessboardCell).isActive = true;
        }
      }
      // Show a snackbar
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text("$currentPlayer has won."),
        ),
      );
    }
    currentPlayer = playerNegate(currentPlayer);
    return messenger.currentPlayer;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // Construct a grid
    boardRows = [];
    for (int i = 0; i < rownum; i++) {
      // Construct columns for one row
      List<Widget> rowChildren = [];
      for (int j = 0; j < colnum; j++) {
        rowChildren.add(ChessboardCell(i, j));
      }
      boardRows.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: boardRows,
    );
  }
}
