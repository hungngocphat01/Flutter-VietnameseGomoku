import 'dart:math';
import 'package:flutter/material.dart';
import 'chessboard_cell.dart';
import 'package:gomoku/util/util.dart';
import 'package:gomoku/util/enum.dart';
import 'package:gomoku/game_processor.dart';
import 'package:tuple/tuple.dart';
import 'package:gomoku/globals.dart' as globals;

class Chessboard extends StatefulWidget {
  Chessboard({Key? key}) : super(key: key);

  static _ChessboardState? of(BuildContext context) {
    final _ChessboardState? result =
        context.findAncestorStateOfType<_ChessboardState>();
    return result;
  }

  @override
  _ChessboardState createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  late GameProcessor _processor;
  late ValueNotifier<Player> _currentPlayer;
  late List<Row> _boardRows;
  late BuildContext _context;
  late double _cellSize;

  double calculateCellSize(int cellnum, double dimension) {
    const minCellSize = 20;
    final cellSize = dimension / cellnum;
    if (cellSize < minCellSize) {
      throw Exception("Too many cells.");
    }
    return cellSize;
  }

  String getPlayerName(Player p) =>
      p == Player.player1 ? "Player 1" : "Player 2";

  @override
  initState() {
    _processor = GameProcessor();
    _currentPlayer = ValueNotifier(Player.player1);
    super.initState();
  }

  Player handleUserClick(int row, int col) {
    // Send data to processor
    TurnMessenger messenger =
        _processor.handleUserMark(row, col, _currentPlayer.value);
    // If game finished (either player has won)
    if (messenger.gameFinished) {
      debugPrint("Game end");
      debugPrint("Victory: ${getPlayerName(messenger.currentPlayer)}");
      // Mark combo cells
      messenger.markedCells?.forEach((c) {
        (_boardRows[c.item1].children[c.item2] as ChessboardCell)
            .isMarked
            .value = true;
      });
      // Disable input
      for (Row row in _boardRows) {
        for (Widget c in row.children) {
          (c as ChessboardCell).isActive = true;
        }
      }
      // Show a snackbar
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text("${getPlayerName(_currentPlayer.value)} has won."),
        ),
      );
    }
    // Notify the current active plasyer so the invoked cell can set its label
    _currentPlayer.value = playerNegate(_currentPlayer.value);
    return messenger.currentPlayer;
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    // Try to determine the size of each cells
    try {
      _cellSize = min(
        min(
          calculateCellSize(
              globals.rowNum, MediaQuery.of(context).size.height - 20),
          calculateCellSize(
              globals.colNum, MediaQuery.of(context).size.width - 20),
        ),
        60,
      );
    }
    // If the cells are too small to display, show an error message
    catch (exception) {
      return Container(
        width: min(MediaQuery.of(context).size.width, 300),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                "There are too many cells on the screen! Please reduce the dimensions of the board."),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }

    // Construct a grid
    _boardRows = [];
    for (int i = 0; i < globals.rowNum; i++) {
      // Construct columns for one row
      List<Widget> rowChildren = [];
      for (int j = 0; j < globals.colNum; j++) {
        rowChildren.add(ChessboardCell(i, j, _cellSize));
      }
      _boardRows.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
      ));
    }

    // Function to build the player label "O Player 1", "X Player 2"
    Widget buildPlayerName(context, player, widget) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child:
                  (player == Player.player1 ? globals.p1Icon : globals.p2Icon),
            ),
            Text(
              getPlayerName(player as Player),
              style: const TextStyle(fontSize: 30),
            ),
          ],
        );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
            // Player name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ValueListenableBuilder(
                  valueListenable: _currentPlayer,
                  builder: (context, player, widget) =>
                      buildPlayerName(context, player, widget)),
            )
          ] +
          _boardRows,
    );
  }
}
