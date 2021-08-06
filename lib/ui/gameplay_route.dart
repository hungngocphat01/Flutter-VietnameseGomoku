import 'package:flutter/material.dart';
import 'game_board.dart';
import 'package:tuple/tuple.dart';

class GameplayRoute extends StatefulWidget {
  const GameplayRoute({Key? key}) : super(key: key);

  @override
  _GameplayRouteState createState() => _GameplayRouteState();
}

class _GameplayRouteState extends State<GameplayRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game"),
      ),
      body: Center(child: Gameboard()),
    );
  }
}
