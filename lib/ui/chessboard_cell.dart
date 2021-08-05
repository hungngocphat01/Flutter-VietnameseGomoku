import 'package:gomoku/ui/chessboard.dart';
import 'package:flutter/material.dart';
import 'package:gomoku/util/player_enum.dart';

class ChessboardCell extends StatefulWidget {
  final int _rowpos;
  final int _colpos;
  final double _size;
  var isMarked = ValueNotifier<bool>(false);
  bool isActive = false;

  ChessboardCell(this._rowpos, this._colpos, this._size, {Key? key})
      : super(key: key);

  @override
  _ChessboardCellState createState() => _ChessboardCellState();
}

class _ChessboardCellState extends State<ChessboardCell> {
  final Icon _p1Icon = const Icon(Icons.panorama_fisheye_sharp);
  final Icon _p2Icon = const Icon(Icons.clear);
  Icon? _activeIcon;

  void onUserClick(BuildContext context) {
    if (widget.isActive) return;

    final parentCbSt = Chessboard.of(context);
    if (parentCbSt != null) {
      widget.isActive = true;
      var player = parentCbSt.handleUserClick(widget._rowpos, widget._colpos);
      setState(() {
        // Player 1
        if (player == Player.player1) {
          _activeIcon = _p1Icon;
        } else {
          _activeIcon = _p2Icon;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onUserClick(context),
      child: ValueListenableBuilder(
        valueListenable: widget.isMarked,
        builder: (context, value, child) => Container(
          width: widget._size,
          height: widget._size,
          decoration: BoxDecoration(
            color: widget.isMarked.value
                ? Colors.greenAccent[100]
                : Colors.lime[50],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: _activeIcon,
        ),
      ),
    );
  }
}
