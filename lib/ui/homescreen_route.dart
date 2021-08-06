import 'package:flutter/material.dart';
import 'package:gomoku/ui/gameplay_route.dart';
import 'package:gomoku/util/util.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class HomescreenRoute extends StatefulWidget {
  const HomescreenRoute({Key? key}) : super(key: key);

  @override
  _HomescreenRouteState createState() => _HomescreenRouteState();
}

class _HomescreenRouteState extends State<HomescreenRoute> {
  @override
  Widget build(BuildContext context) {
    var screendim = Provider.of<BoardSize>(context);

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
                    label: screendim.getWidth().toString(),
                    value: screendim.width,
                    onChanged: (double x) =>
                        setState(() => screendim.width = x),
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
                    label: screendim.getHeight().toString(),
                    value: screendim.height,
                    onChanged: (double x) =>
                        setState(() => screendim.height = x),
                    min: 1,
                    max: 20,
                    divisions: 19,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameplayRoute(),
                    ),
                  );
                },
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
