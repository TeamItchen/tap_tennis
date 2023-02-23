import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'components/tap_tennis_game.dart';

class MyGame extends StatefulWidget {
  @override
  _MyGamePlay createState() => _MyGamePlay();
}

class _MyGamePlay extends State<MyGame> {
  @override
  Widget build(BuildContext context) {
    TapTennisGame game = TapTennisGame();
    return GameWidget(game: game);
  }
}
