import 'package:flutter/material.dart';
import 'package:gomoku/ui/homescreen_route.dart';
import 'package:provider/provider.dart';
import 'util/util.dart';

void main() {
  runApp(
    Provider(
      create: (context) => BoardSize(),
      builder: (context, widget) => const MaterialApp(
        title: "Cờ carô",
        home: HomescreenRoute(),
      ),
    ),
  );
}

// TODO: refactor code