import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:tap_tennis/dashboard/dashboard.dart';

import '/components/tap_tennis_game.dart';

main() {
  runApp(createGameWidget());
}

Widget createGameWidget() {
  TapTennisGame game = TapTennisGame();
  Flame.device.fullScreen();
  return Scaffold(
    body: GameWidget(
      game: game,
      overlayBuilderMap: {
        'DashboardOverlay': (BuildContext context, TapTennisGame game) {
          return Dashboard(game: game);
        }
      },
    ),
  );
}
