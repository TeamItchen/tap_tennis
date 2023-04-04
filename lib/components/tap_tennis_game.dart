import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:tap_tennis/components/paddle.dart';
import 'package:tap_tennis/components/ball.dart';

class TapTennisGame extends FlameGame with HasCollisionDetection, TapDetector {
  //Sprites
  Paddle playerPaddle = Paddle();
  Paddle computerPaddle = Paddle();
  Ball ball = Ball();

  //Game variables
  String compDirection = "down";
  String playerDirection = "stop";
  String ballXDirection = "right";
  String ballYDirection = "up";
  double paddleSpeed = 2;
  double ballSpeed = 2;
  bool paddleHit = false;

  //Method to show whether a paddle has hit the ball
  paddleHitBall(bool hitBall) {
    paddleHit = hitBall;
  }

  //Load game assets
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    playerPaddle.position = Vector2(size[0] - 50, 150);
    add(playerPaddle);

    computerPaddle.position = Vector2(50, 150);
    add(computerPaddle);

    ball.position = Vector2(size[0] / 2, size[1] / 2);
    add(ball);

    //Paddle placement reflects screen size, but only on refresh-
    //Need to implement an auto refresh - 09/02/2023
    // @override
    // update(double dt) {
    //   super.update(dt);
    //   playerPaddle.position = Vector2(size[0] - 75, 150);
    // }
  }

  //Main game controls
  @override
  update(double dt) {
    super.update(dt);

    //Movement X options for ball
    switch (ballXDirection) {
      case "right":
        ball.x += ballSpeed;
        break;
      case "left":
        ball.x -= ballSpeed;
        break;
    }

    //Movement Y options for ball
    switch (ballYDirection) {
      case "down":
        ball.y += ballSpeed;
        break;
      case "up":
        ball.y -= ballSpeed;
        break;
    }

    //Ball movement code
    if (ball.x <= 75 && paddleHit == true) {
      ballXDirection = "right";
    }
    if (ball.x >= size[0] - 75 && paddleHit == true) {
      ballXDirection = "left";
    }
    if (ball.y > size[1] - 25) {
      ballYDirection = "up";
    }
    if (ball.y < 0) {
      ballYDirection = "down";
    }

    /*Returns paddleHit back to false after the ball has hit the paddle so that
		the game can detect when the ball has passed a paddle after the first move.*/
    paddleHit = false;

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
