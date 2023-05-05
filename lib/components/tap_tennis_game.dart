import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:tap_tennis/components/paddle.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/score.dart';
import 'package:tap_tennis/data_persistence.dart' as data;
import 'package:tap_tennis/components/power_up_speed.dart';
import 'package:tap_tennis/components/power_up_length.dart';
import 'package:tap_tennis/components/power_up_ball_size.dart';
import 'package:tap_tennis/score_submitter.dart' as submit;
import 'package:tap_tennis/components/power_up_paddle_speed.dart';
import 'package:tap_tennis/components/portal.dart';

int score = 0;

class TapTennisGame extends FlameGame with HasCollisionDetection, TapDetector {
  //Sprites
  Paddle playerPaddle = Paddle();
  Paddle computerPaddle = Paddle();
  Ball ball = Ball();
  Score scoreCounter = Score();

  PowerUpSpeed powerupspeed = PowerUpSpeed();
  PowerUpLength poweruplength = PowerUpLength();
  PowerUpBallSize bigBall = PowerUpBallSize();
  PowerUpPaddleSpeed speedpaddle = PowerUpPaddleSpeed();
  PowerUpPortal powerupportal = PowerUpPortal();
  PowerUpPortal powerupportal2 = PowerUpPortal();

  late List powerUps = [powerupspeed, poweruplength, bigBall, powerupportal];

  //Game variables
  String compDirection = "down";
  String playerDirection = "stop";
  String ballXDirection = "right";
  String ballYDirection = "up";
  bool paddleHit = false;
  bool powerUpSpeedHit = false;
  bool powerUpLengthHit = false;
  bool powerUpBigHit = false;
  bool powerUpPadspeedHit = false;
  bool powerUpPortalHit = false;
  bool _cooldown = false;
  bool _powerUpExists = false;

  //Method to show whether a paddle has hit the ball
  paddleHitBall(bool hitBall) {
    paddleHit = hitBall;
  }

  //When powerUpSpeed is hit, the powerUpSpeedHit variable is set to true for 5 seconds
  //Whilst this is true, setBallSpeed will alter the ball speed
  void powerUpSpeedHitBall(bool hitBall) async {
    powerUpSpeedHit = hitBall;
    await Future.delayed(Duration(seconds: 5));
    powerUpSpeedHit = !hitBall;
    _powerUpExists = false;
  }

  //When poweruplength is hit, the powerUpLengthHit variable is set to true for 5 seconds
  ////Whilst this is true, setPaddleLength will alter the paddle length
  void powerUpLengthHitBall(bool hitBall) async {
    powerUpLengthHit = hitBall;
    await Future.delayed(const Duration(seconds: 5));
    powerUpLengthHit = !hitBall;
    _powerUpExists = false;
  }

  // There 2 methods both perform a check to see if their respective powerups have been hit or not. then acts accordingly.
  void powerUpBigHitBall(bool hitBall) async {
    powerUpBigHit = hitBall;
    await Future.delayed(const Duration(seconds: 5));
    powerUpBigHit = !hitBall;
    _powerUpExists = false;
  }

  void powerUpPadSpeedBall(bool hitBall) async {
    powerUpPadspeedHit = hitBall;
    await Future.delayed(const Duration(seconds: 5));
    powerUpPadspeedHit = !hitBall;
    _powerUpExists = false;
  }

  void powerUpPortalHitBall(bool hitBall) async {
    powerUpPortalHit = hitBall;
    powerUpPortalHit = !hitBall;
    _powerUpExists = false;
  }

  //Method that updates the player's score
  updateScore() {
    if (_cooldown == false) {
      score += 1;
    }
    //Cooldown of 1 second to prevent it triggering more than once when the ball hits the paddle
    _cooldown = true;
    Future.delayed(const Duration(seconds: 1), () {
      _cooldown = false;
    });
  }

  //Set Ball Speed
  Future<double> setBallSpeed(powerUpSpeedHit) async {
    double ballSpeed = await data.getBallSpeed();
    if (powerUpSpeedHit == true) {
      ballSpeed /= 4;
    }
    return ballSpeed;
  }

  // Set Paddle length
  Future<Vector2> setPaddleLength(powerUpLengthHit) async {
    playerPaddle.size = Vector2(25, 100);
    if (powerUpLengthHit == true) {
      playerPaddle.size = Vector2(25, 150);
    }
    return playerPaddle.size;
  }

  //Set Paddle Speed
  Future<double> setPaddleSpeed(speedpad) async {
    double paddlespeed = await data.getPaddleSpeed();
    if (speedpad == true) {
      paddlespeed *= 2;
    }
    return paddlespeed;
  }

  // Set ball size (setBallSize)
  Future<Vector2> setBallSize(hitDone) async {
    ball.size = Vector2(25, 25);
    if (hitDone == true) {
      ball.size = Vector2(50, 50);
    }
    return ball.size;
  }

  void placePortal(hit, portaltype) {
    if (hit == true && portaltype == true) {
      ball.position = Vector2(powerupportal2.x, powerupportal2.y);
    } else if (hit == true && portaltype == false) {
      ball.position = Vector2(powerupportal.x, powerupportal.y);
    }
  }

  //Random Power Up Spawner
  Future<bool> powerUpSpawner(powerUpExists, sizeX, sizeY) async {
    if (powerUpExists == false) {
      Random random = new Random();
      double powerUpX = (random.nextInt(sizeX.round() - 200) + 100).toDouble();
      double powerUpY = (random.nextInt(sizeY.round() - 100) + 50).toDouble();
      var i = random.nextInt(powerUps.length);
      powerUps[i].position = Vector2(powerUpX, powerUpY);
      add(powerUps[i]);
      if (powerUps[i] == powerupportal) {
        double powerUpX =
            (random.nextInt(sizeX.round() - 200) + 100).toDouble();
        double powerUpY = (random.nextInt(sizeY.round() - 100) + 50).toDouble();
        powerupportal2.position = Vector2(powerUpX, powerUpY);
        powerupportal.portal =
            true; // true represents the 1st portal(false = 2nd) , used to differentiate between the 2 portals
        add(powerupportal2);
      }
      powerUpExists = true;
    }
    return powerUpExists;
  }

  //Load game assets
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    score = 0;

    playerPaddle.position = Vector2(size[0] - 50, 150);
    add(playerPaddle);

    computerPaddle.position = Vector2(50, 150);
    add(computerPaddle);

    ball.position = Vector2(size[0] / 2, size[1] / 2);
    add(ball);

    scoreCounter.position = Vector2(size[0] / 2, 10);
    add(scoreCounter);

    overlays.add('DashboardOverlay');
  }

  //Main game controls
  @override
  update(double dt) async {
    super.update(dt);

    //Spawn power up if it doesn't exist
    _powerUpExists = await powerUpSpawner(_powerUpExists, size[0], size[1]);

    double ballSpeed = await setBallSpeed(powerUpSpeedHit);
    double paddleSpeed = await setPaddleSpeed(powerUpPadspeedHit);
    playerPaddle.size = await setPaddleLength(powerUpLengthHit);
    ball.size = await setBallSize(powerUpBigHit);

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
      updateScore();
    }
    if (ball.x < -25 || ball.x > size[0] + 25) {
      pauseEngine();
      overlays.add('GameOverOverlay');
      submit.retrieveData();
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
        computerPaddle.y += 5;
        break;
      case "up":
        computerPaddle.y -= 5;
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

    //P-UP
    if (powerUpSpeedHit == true) {
      powerupspeed.removeFromParent();
    }

    if (powerUpLengthHit == true) {
      poweruplength.removeFromParent();
    }
    if (powerUpBigHit == true) {
      bigBall.removeFromParent();
    }
    if (powerUpPadspeedHit = true) {
      speedpaddle.removeFromParent();
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
