import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

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
  String triangleAnimationAsset = "assets/trianglebtn.riv";
  String starAnimationAsset = "assets/starbtn.riv";
  String squareAnimationAsset = "assets/squarebtn.riv";
  String circularAnimationAsset = "assets/circularbtn.riv";

  late RiveAnimationController _controllerSqr;
  late RiveAnimationController _controllerCrl;
  late RiveAnimationController _controllerTrg;
  late RiveAnimationController _controllerStr;

  bool _isPlayingSqr = false;
  bool _isPlayingCrl = false;
  bool _isPlayingTrg = false;
  bool _isPlayingStr = false;

  final double edgeInsets = 15.0;

  var score = 0;
  bool _isPlaying = false;

  void playSound(String pathName) async {
    await AssetsAudioPlayer.newPlayer().open(
      Audio(pathName),
      showNotification: true,
    );
  }

  void playNote(int i) {
    switch (i) {
      case 1:
        playSound("assets/sound/note1.wav");
        break;
      case 2:
        playSound("assets/sound/note3.wav");
        break;
      case 3:
        playSound("assets/sound/note5.wav");
        break;
      case 4:
        playSound("assets/sound/note7.wav");
        break;
      default:
    }
  }

  void playSuccess() {
    playSound("assets/sound/ChildrenYeah.mp3");
  }

  void playArraySuccess() {
    playSound("assets/sound/ChildrenYeah.mp3");
  }

  void playFailure() {
    playSound("assets/sound/FunnyBell.mp3");
  }

  @override
  void initState() {
    /// #region controller setup
    _controllerSqr = OneShotAnimation(
      'Animation 1',
      autoplay: false,
      onStop: () => setState(() => _isPlayingSqr = false),
      onStart: () => setState(() => _isPlayingSqr = true),
    );
    _controllerCrl = OneShotAnimation(
      'Animation 1',
      autoplay: false,
      onStop: () => setState(() => _isPlayingCrl = false),
      onStart: () => setState(() => _isPlayingCrl = true),
    );
    _controllerTrg = OneShotAnimation(
      'Animation 1',
      autoplay: false,
      onStop: () => setState(() => _isPlayingTrg = false),
      onStart: () => setState(() => _isPlayingTrg = true),
    );
    _controllerStr = OneShotAnimation(
      'Animation 1',
      autoplay: false,
      onStop: () => setState(() => _isPlayingStr = false),
      onStart: () => setState(() => _isPlayingStr = true),
    );
  }

  Widget btn(double? h, double? w, int btnIndex, String animation,
      RiveAnimationController _controller) {
    return Container(
      height: h,
      width: w,
      child: GestureDetector(
        onTap: () {
          switch (btnIndex) {
            case 0:
              _isPlayingTrg ? null : _controllerTrg.isActive = true;
              break;
            case 1:
              _isPlayingStr ? null : _controllerStr.isActive = true;
              break;
            case 2:
              _isPlayingSqr ? null : _controllerSqr.isActive = true;
              break;
            case 3:
              _isPlayingCrl ? null : _controllerCrl.isActive = true;
              break;
            default:
          }
        },
        child: RiveAnimation.asset(animation,
            animations: const ['Animation 1'], controllers: [_controller]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(100.0),
                    child: CustomPaint(
                      size: Size(200, 200),
                      painter: CirclePainter(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            score = 0;
                          });
                        },
                        child: Text(
                          score.toString(),
                          style: TextStyle(fontSize: 70, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                      child: new Icon(
                        _isPlaying ? Icons.pause_rounded : Icons.play_arrow,
                        color: Colors.white,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(edgeInsets),
                    child: btn(
                        130, 130, 0, triangleAnimationAsset, _controllerTrg),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(edgeInsets),
                    child: btn(130, 130, 1, starAnimationAsset, _controllerStr),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(edgeInsets),
                    child:
                        btn(130, 130, 2, squareAnimationAsset, _controllerSqr),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(edgeInsets),
                    child: btn(
                        130, 130, 3, circularAnimationAsset, _controllerCrl),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 15;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 80, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
