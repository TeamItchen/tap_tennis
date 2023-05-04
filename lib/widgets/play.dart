import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import '/components/tap_tennis_game.dart';

main() {
  runApp(createGameWidget());
}

Widget createGameWidget() {
  TapTennisGame game = TapTennisGame();
  Flame.device.fullScreen(); // todo-sam: have stateful?
  return GameWidget(game: game);
}
