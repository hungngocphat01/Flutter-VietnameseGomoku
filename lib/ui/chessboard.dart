import 'package:flutter/material.dart';
import 'chessboard_cell.dart';

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
  int rownum = 5;
  int colnum = 5;

  bool currentPlayer = false;

  bool handleUserClick(int col, int row) {
    debugPrint("Received signal: $col, $row");
    currentPlayer = !currentPlayer;
    return !currentPlayer;
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
