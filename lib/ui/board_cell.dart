import 'package:gomoku/ui/game_board.dart';
import 'package:flutter/material.dart';
import 'package:gomoku/util/enum.dart';
import 'package:gomoku/globals.dart' as globals;

class BoardCell extends StatefulWidget {
  final int _rowpos;
  final int _colpos;
  final double _size;

  BoardCell(this._rowpos, this._colpos, this._size, {Key? key})
      : super(key: key);

  @override
  BoardCellState createState() => BoardCellState();
}

class BoardCellState extends State<BoardCell> {
  Icon? _activeIcon;
  bool _isMarked = false;
  bool _isDisabled = false;
  bool _isInitialized = false;

  invokeMarked() {
    setState(() {
      _isMarked = true;
    });
  }

  invokeActive() {
    setState(() {
      _isDisabled = true;
    });
  }

  void _onUserClick(BuildContext context) {
    if (_isDisabled) return;

    final parentGmbState = Gameboard.of(context);
    if (parentGmbState != null) {
      _isDisabled = true;
      var player =
          parentGmbState.handleUserClick(widget._rowpos, widget._colpos);
      setState(() {
        // Player 1
        if (player == Player.player1) {
          _activeIcon = globals.p1Icon;
        } else {
          _activeIcon = globals.p2Icon;
        }
      });
    } else {
      throw Exception(
          "Cell (${widget._rowpos}, ${widget._colpos}): parent Gameboard was null.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onUserClick(context),
      child: Container(
        width: widget._size,
        height: widget._size,
        decoration: BoxDecoration(
          color: _isMarked ? Colors.greenAccent[100] : Colors.lime[50],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: _activeIcon,
      ),
    );
  }
}
