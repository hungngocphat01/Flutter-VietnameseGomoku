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

  _ChessboardState() : super() {
    rownum = 5;
    colnum = 5;
    processor = GameProcessor(rownum: rownum, colnum: colnum);
    currentPlayer = Player.player1;
  }

  Player handleUserClick(int row, int col) {
    currentPlayer = playerNegate(currentPlayer);

    TurnMessenger messenger = processor.handleUserMark(row, col, currentPlayer);
    // TODO: Process information returned by processor
    return currentPlayer;
  }

  @override
  Widget build(BuildContext context) {
    // Construct a grid
    List<Row> boardRows = [];
    for (int i = 0; i < rownum; i++) {
      // Construct columns for one row
      List<Widget> rowChildren = [];
      for (int j = 0; j < colnum; j++) {
        rowChildren.add(ChessboardCell(i, j));
      }
      boardRows.add(Row(children: rowChildren));
    }
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => (boardRows[0].children[0] as ChessboardCell)
              .isMarked
              .value = true,
          child: const Text("test marker"),
        ),
        Column(
          children: boardRows,
        ),
      ],
    );
  }
}
