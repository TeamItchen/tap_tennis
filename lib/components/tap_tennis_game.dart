import 'dart:io';

import 'package:flame/game.dart';
import 'package:tap_tennis/components/paddle.dart';

class TapTennisGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    print(size);
    Paddle playerPaddle = Paddle(position: Vector2(size[0] - 75, 150));
    add(playerPaddle);

    Paddle computerPaddle = Paddle(position: Vector2(0, 150));
    add(computerPaddle);

    //Paddle placement reflects screen size, but only on refresh-
    //Need to implement an auto refresh - 09/02/2023
    @override
    update(double dt) {
      super.update(dt);
      playerPaddle.position = Vector2(size[0] - 75, 150);
    }
  }
}
