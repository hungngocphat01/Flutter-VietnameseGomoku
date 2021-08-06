import 'dart:math';
import 'package:flutter/material.dart';
import 'board_cell.dart';
import 'package:gomoku/util/util.dart';
import 'package:gomoku/util/enum.dart';
import 'package:gomoku/game_processor.dart';
import 'package:provider/provider.dart';
import 'package:gomoku/globals.dart' as globals;

class Gameboard extends StatefulWidget {
  const Gameboard({Key? key}) : super(key: key);

  static _GameboardState? of(BuildContext context) {
    final _GameboardState? result =
        context.findAncestorStateOfType<_GameboardState>();
    return result;
  }

  @override
  _GameboardState createState() => _GameboardState();
}

class _GameboardState extends State<Gameboard> {
  final ValueNotifier<Player> _currentPlayer = ValueNotifier(Player.player1);
  late GameProcessor _processor;
  late List<Row> _boardRows;
  late BuildContext _context;
  late double _cellSize;
  late BoardSize _boardsize;
  bool stateInitialized = false;

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
  didChangeDependencies() {
    super.didChangeDependencies();
    if (stateInitialized) {
      return;
    }
    _boardsize = Provider.of<BoardSize>(context);
    _processor = GameProcessor(_boardsize.getHeight(), _boardsize.getWidth());
    _context = context;
    stateInitialized = true;
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
        (_boardRows[c.item1].children[c.item2] as BoardCell).isMarked.value =
            true;
      });
      // Disable input
      for (Row row in _boardRows) {
        for (Widget c in row.children) {
          (c as BoardCell).isActive = true;
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
    // Try to determine the size of each cells
    try {
      _cellSize = min(
        min(
          calculateCellSize(
              _boardsize.getHeight(), MediaQuery.of(context).size.height - 20),
          calculateCellSize(
              _boardsize.getWidth(), MediaQuery.of(context).size.width - 20),
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
    for (int i = 0; i < _boardsize.height; i++) {
      // Construct columns for one row
      List<Widget> rowChildren = [];
      for (int j = 0; j < _boardsize.width; j++) {
        rowChildren.add(BoardCell(i, j, _cellSize));
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
