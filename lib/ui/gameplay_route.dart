import 'package:flutter/material.dart';
import 'chessboard.dart';
import '../game_processor.dart';

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
        title: const Text("Flutter Five In A Row"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: const Chessboard(),
      ),
    );
  }
}
