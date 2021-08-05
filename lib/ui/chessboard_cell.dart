import 'package:gomoku/ui/chessboard.dart';
import 'package:flutter/material.dart';
import 'package:gomoku/player_enum.dart';

class ChessboardCell extends StatefulWidget {
  final int rowpos;
  final int colpos;
  var isMarked = ValueNotifier<bool>(false);
  bool isActive = false;

  ChessboardCell(this.rowpos, this.colpos, {Key? key}) : super(key: key);

  @override
  _ChessboardCellState createState() => _ChessboardCellState();
}

class _ChessboardCellState extends State<ChessboardCell> {
  Icon p1Icon = const Icon(Icons.panorama_fisheye_sharp);
  Icon p2Icon = const Icon(Icons.clear);
  Icon? activeIcon;

  void onUserClick(BuildContext context) {
    if (widget.isActive) return;

    final parentCbSt = Chessboard.of(context);
    if (parentCbSt != null) {
      widget.isActive = true;
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
            color: widget.isMarked.value
                ? Colors.greenAccent[100]
                : Colors.lime[50],
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: activeIcon,
        ),
      ),
    );
  }
}
