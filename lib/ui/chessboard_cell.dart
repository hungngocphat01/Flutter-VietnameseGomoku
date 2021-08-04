import 'package:gomoku/ui/chessboard.dart';
import 'package:flutter/material.dart';
import 'package:gomoku/player_enum.dart';

class ChessboardCell extends StatefulWidget {
  final int rowpos;
  final int colpos;
  var isMarked = ValueNotifier<bool>(false);

  ChessboardCell(this.rowpos, this.colpos, {Key? key}) : super(key: key);

  @override
  _ChessboardCellState createState() => _ChessboardCellState();
}

class _ChessboardCellState extends State<ChessboardCell> {
  Icon p1Icon = const Icon(Icons.panorama_fisheye_sharp);
  Icon p2Icon = const Icon(Icons.clear);
  Icon? activeIcon;

  bool isActive = false;

  void onUserClick(BuildContext context) {
    if (isActive) return;

    final parentCbSt = Chessboard.of(context);
    if (parentCbSt != null) {
      isActive = true;
      var player = parentCbSt.handleUserClick(widget.rowpos, widget.colpos);
      setState(() {
        // Player 1
        if (player == Player.player1) {
          activeIcon = p1Icon;
        } else {
          activeIcon = p2Icon;
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
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: widget.isMarked.value ? Colors.red : Colors.greenAccent,
            border: Border.all(color: Colors.grey),
          ),
          child: activeIcon,
        ),
      ),
    );
  }
}
