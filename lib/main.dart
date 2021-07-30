import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: MemoryGame()));
}

class MemoryGame extends StatefulWidget {
  const MemoryGame({Key? key}) : super(key: key);

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // score label
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                  ),
                ),
              ],
            ),
            //start button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.all(26.0),
                child: Container(
                      height: 130,
                      width: 130,
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        onPressed: () {},
                        elevation: 1,
                      ),
                    ),),
              ],
            ),
            //play buttons
            Row(
              children: [],
            ),
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}
