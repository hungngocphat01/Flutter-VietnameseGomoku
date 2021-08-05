import 'package:flutter/material.dart';
import 'chessboard.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Cờ carô phờ-lớt-tơ"),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: const Center(child: Chessboard()),
    );
  }
}
