import 'dart:io';
import 'package:flame/src/gestures/detectors.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tap_tennis/components/paddle.dart';

class TapTennisGame extends FlameGame with HasCollisionDetection, TapDetector {
  Paddle playerPaddle = Paddle();
  Paddle computerPaddle = Paddle();

  String compDirection = "down";
  String playerDirection = "stop";
  double paddleSpeed = 2;

  @override
  Future<void> onLoad() async {
    print(size);
    await super.onLoad();

    //add(ScreenHitbox());

    playerPaddle.position = Vector2(size[0] - 50, 150);
    add(playerPaddle);

    computerPaddle.position = Vector2(50, 150);
    add(computerPaddle);

    //Paddle placement reflects screen size, but only on refresh-
    //Need to implement an auto refresh - 09/02/2023
    @override
    update(double dt) {
      super.update(dt);
      playerPaddle.position = Vector2(size[0] - 75, 150);
    }
  }

  @override
  update(double dt) {
    super.update(dt);

    //Movement options for computer paddle
    switch (compDirection) {
      case "down":
        computerPaddle.y += 1;
        break;
      case "up":
        computerPaddle.y -= 1;
        break;
    }

    //TEMPORARY computer movement code
    if (computerPaddle.y > size[1] - 100) {
      compDirection = "up";
    }
    if (computerPaddle.y < 0) {
      compDirection = "down";
    }

    //Movement options for player paddle
    switch (playerDirection) {
      case "down":
        playerPaddle.y += paddleSpeed;
        break;
      case "up":
        playerPaddle.y -= paddleSpeed;
        break;
      case "stop":
        playerPaddle.y += 0;
        break;
    }

    //Player edge detection
    if (playerPaddle.y > size[1] - 100) {
      playerDirection = "stop";
    }
    if (playerPaddle.y < 0) {
      playerDirection = "stop";
    }
  }

  //Player movement code
  @override
  void onTapDown(TapDownInfo info) {
    var tapCoordinates = info.eventPosition.game;
    print("Press ${tapCoordinates.y}");

    if (tapCoordinates.y > size[1] / 2) {
      playerDirection = "down";
    }
    if (tapCoordinates.y <= size[1] / 2) {
      playerDirection = "up";
    }
  }

  //Player stop code
  @override
  void onTapUp(TapUpInfo info) {
    playerDirection = "stop";
  }
}
