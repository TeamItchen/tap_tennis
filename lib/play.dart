import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'components/tap_tennis_game.dart';

main() {
  TapTennisGame game = TapTennisGame();
  runApp(GameWidget(game: game));
}
