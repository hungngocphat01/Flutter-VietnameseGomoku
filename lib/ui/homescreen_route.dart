import 'package:flutter/material.dart';
import 'package:gomoku/ui/gameplay_route.dart';
import 'dart:math';

import 'package:tuple/tuple.dart';

class HomescreenRoute extends StatefulWidget {
  const HomescreenRoute({Key? key}) : super(key: key);

  @override
  _HomescreenRouteState createState() => _HomescreenRouteState();
}

class _HomescreenRouteState extends State<HomescreenRoute> {
  double colNum = 1;
  double rowNum = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: min(MediaQuery.of(context).size.width, 300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  "Cờ carô",
                  style: TextStyle(fontSize: 40),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Columns: "),
                  Slider(
                    label: colNum.round().toString(),
                    value: colNum,
                    onChanged: (double x) => setState(() => colNum = x),
                    min: 1,
                    max: 20,
                    divisions: 19,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Rows: "),
                  Slider(
                    label: rowNum.round().toString(),
                    value: rowNum,
                    onChanged: (double x) => setState(() => rowNum = x),
                    min: 1,
                    max: 20,
                    divisions: 19,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GameplayRoute(Tuple2(rowNum.round(), colNum.round())),
                  ),
                ),
                child: const Text("Play!"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 30),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("(c) 2021 Hùng Ngọc Phát"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
