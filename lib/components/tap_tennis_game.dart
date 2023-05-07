import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:tap_tennis/components/paddle.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/score.dart';
import 'package:tap_tennis/data_persistence.dart' as data;
import 'package:tap_tennis/components/power_up_ball_speed.dart';
import 'package:tap_tennis/components/power_up_ball_size.dart';
import 'package:tap_tennis/components/power_up_paddle_speed.dart';
import 'package:tap_tennis/components/power_up_paddle_size.dart';
import 'package:tap_tennis/components/obstacle_ball_speed.dart';
import 'package:tap_tennis/components/obstacle_ball_size.dart';
import 'package:tap_tennis/components/obstacle_paddle_speed.dart';
import 'package:tap_tennis/components/obstacle_paddle_size.dart';
import 'package:tap_tennis/score_submitter.dart' as submit;
import 'package:audioplayers/audioplayers.dart';

int score = 0;

class TapTennisGame extends FlameGame with HasCollisionDetection, TapDetector {
  //Sprites
  Paddle playerPaddle = Paddle();
  Paddle computerPaddle = Paddle();
  Ball ball = Ball();
  Score scoreCounter = Score();

  PowerUpBallSpeed powerupballspeed = PowerUpBallSpeed();
  PowerUpBallSize powerupballsize = PowerUpBallSize();
  PowerUpPaddleSpeed poweruppaddlespeed = PowerUpPaddleSpeed();
  PowerUpPaddleSize poweruppaddlesize = PowerUpPaddleSize();
  late List powerUps = [
    powerupballspeed,
    powerupballsize,
    poweruppaddlespeed,
    poweruppaddlesize
  ];

  ObstacleBallSpeed obstacleballspeed = ObstacleBallSpeed();
  ObstacleBallSize obstacleballsize = ObstacleBallSize();
  ObstaclePaddleSpeed obstaclepaddlespeed = ObstaclePaddleSpeed();
  ObstaclePaddleSize obstaclepaddlesize = ObstaclePaddleSize();
  late List obstacles = [
    obstacleballspeed,
    obstacleballsize,
    obstaclepaddlespeed,
    obstaclepaddlesize
  ];

  //Game variables
  String compDirection = "down";
  String playerDirection = "stop";
  String ballXDirection = "right";
  String ballYDirection = "up";

  bool paddleHit = false;
  bool _cooldown = false;

  bool powerUpBallSpeedHit = false;
  bool powerUpBallSizeHit = false;
  bool powerUpPaddleSpeedHit = false;
  bool powerUpPaddleSizeHit = false;
  bool _powerUpExists = false;

  bool obstacleBallSpeedHit = false;
  bool obstacleBallSizeHit = false;
  bool obstaclePaddleSpeedHit = false;
  bool obstaclePaddleSizeHit = false;
  bool _obstacleExists = false;

  bool powerUpsActive = false;
  bool obstaclesActive = false;

  static const double paddleWidth = 25;
  static const double paddlePosOffset = 25;

  //Method to show whether a paddle has hit the ball
  paddleHitBall(bool hitBall) {
    paddleHit = hitBall;
  }

  //When powerUpBallSpeed is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, powerUpExists is set to false to alert the game to generate a new power-up sprite.
  void powerUpBallSpeedHitBall(bool hitBall) async {
    powerUpBallSpeedHit = hitBall;
    playPop();
    await Future.delayed(Duration(seconds: 5));
    powerUpBallSpeedHit = !hitBall;
    _powerUpExists = false;
  }

  //When powerUpBallSize is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, powerUpExists is set to false to alert the game to generate a new power-up sprite.
  void powerUpBallSizeHitBall(bool hitBall) async {
    powerUpBallSizeHit = hitBall;
    playPop();
    await Future.delayed(Duration(seconds: 5));
    powerUpBallSizeHit = !hitBall;
    _powerUpExists = false;
  }

  //When powerUpPaddleSpeed is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, powerUpExists is set to false to alert the game to generate a new power-up sprite.
  void powerUpPaddleSpeedHitBall(bool hitBall) async {
    powerUpPaddleSpeedHit = hitBall;
    playPop();
    await Future.delayed(Duration(seconds: 5));
    powerUpPaddleSpeedHit = !hitBall;
    _powerUpExists = false;
  }

  //When powerUpPaddleSize is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, powerUpExists is set to false to alert the game to generate a new power-up sprite.
  void powerUpPaddleSizeHitBall(bool hitBall) async {
    powerUpPaddleSizeHit = hitBall;
    playPop();
    await Future.delayed(const Duration(seconds: 5));
    powerUpPaddleSizeHit = !hitBall;
    _powerUpExists = false;
  }

  //When obstacleBallSpeed is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, obstacleExists is set to false to alert the game to generate a new obstacle sprite.
  void obstacleBallSpeedHitBall(bool hitBall) async {
    obstacleBallSpeedHit = hitBall;
    playBeep();
    await Future.delayed(Duration(seconds: 5));
    obstacleBallSpeedHit = !hitBall;
    _obstacleExists = false;
  }

  //When obstacleBallSize is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, obstacleExists is set to false to alert the game to generate a new obstacle sprite.
  void obstacleBallSizeHitBall(bool hitBall) async {
    obstacleBallSizeHit = hitBall;
    playBeep();
    await Future.delayed(Duration(seconds: 5));
    obstacleBallSizeHit = !hitBall;
    _obstacleExists = false;
  }

  //When obstaclePaddleSpeed is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, obstacleExists is set to false to alert the game to generate a new obstacle sprite.
  void obstaclePaddleSpeedHitBall(bool hitBall) async {
    obstaclePaddleSpeedHit = hitBall;
    playBeep();
    await Future.delayed(Duration(seconds: 5));
    obstaclePaddleSpeedHit = !hitBall;
    _obstacleExists = false;
  }

  //When obstaclePaddleSize is hit, the powerUpBallSpeedHit variable is set to true for 5 seconds. Whilst this is true, the powerup is applied.
  //Afterwards, obstacleExists is set to false to alert the game to generate a new obstacle sprite.
  void obstaclePaddleSizeHitBall(bool hitBall) async {
    obstaclePaddleSizeHit = hitBall;
    playBeep();
    await Future.delayed(const Duration(seconds: 5));
    obstaclePaddleSizeHit = !hitBall;
    _obstacleExists = false;
  }

  //Sound effects
  final player = AudioPlayer();
  void playTap() async {
    player.play(AssetSource('../../assets/audios/Tap.mp3'));
  }
  void playPop() async {
    player.play(AssetSource('../../assets/audios/Pop.mp3'));
  }
  void playBeep() async {
    player.play(AssetSource('../../assets/audios/Beep.mp3'));
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
  Future<double> setBallSpeed(powerUpBallSpeedHit, obstacleBallSpeedHit) async {
    double ballSpeed = await data.getBallSpeed();
    if (powerUpBallSpeedHit == true) {
      ballSpeed /= 4;
    }
    if (obstacleBallSpeedHit == true) {
      ballSpeed *= 2;
    }
    return ballSpeed;
  }

  //Set Ball Size
  Future<Vector2> setBallSize(powerUpBallSizeHit, obstacleBallSizeHit) async {
    ball.size = Vector2(25, 25);
    if (powerUpBallSizeHit == true) {
      ball.size.x += 25;
      ball.size.y += 25;
    }
    if (obstacleBallSizeHit == true) {
      ball.size.x -= 12.5;
      ball.size.y -= 12.5;
    }
    return ball.size;
  }

  //Set Paddle Speed
  Future<double> setPaddleSpeed(
      powerUpPaddleSpeedHit, obstaclePaddleSpeedHit) async {
    double paddleSpeed = await data.getPaddleSpeed();
    if (powerUpPaddleSpeedHit == true) {
      paddleSpeed *= 2;
    }
    if (obstaclePaddleSpeedHit == true) {
      paddleSpeed /= 2;
    }
    return paddleSpeed;
  }

  //Set Paddle Size
  Future<Vector2> setPaddleLength(
      powerUpPaddleSizeHit, obstaclePaddleSizeHit) async {
    playerPaddle.size = Vector2(paddleWidth, 100);
    if (powerUpPaddleSizeHit == true) {
      playerPaddle.size.y = 150;
    }
    if (obstaclePaddleSizeHit == true) {
      playerPaddle.size.y = 50;
    }
    // todo sam: make paddle grow from middle and not top? (adjust position)
    return playerPaddle.size;
  }

  //Get Power-Ups Status
  Future<bool> powerUpsStatus() async {
    powerUpsActive = await data.getPowerUpsStatus();
    return powerUpsActive;
  }

  //Get Obstacles Status
  Future<bool> obstaclesStatus() async {
    obstaclesActive = await data.getObstaclesStatus();
    return obstaclesActive;
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
      powerUpExists = true;
    }
    return powerUpExists;
  }

  //Random Obstacle Spawner
  Future<bool> obstacleSpawner(obstacleExists, sizeX, sizeY) async {
    if (obstacleExists == false) {
      Random random = new Random();
      double obstacleX = (random.nextInt(sizeX.round() - 200) + 100).toDouble();
      double obstacleY = (random.nextInt(sizeY.round() - 100) + 50).toDouble();
      var i = random.nextInt(obstacles.length);
      obstacles[i].position = Vector2(obstacleX, obstacleY);
      add(obstacles[i]);
      obstacleExists = true;
    }
    return obstacleExists;
  }

  //Load game assets
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    score = 0;

    playerPaddle.position = Vector2(size[0] - paddlePosOffset - paddleWidth, 150);
    add(playerPaddle);

    computerPaddle.position = Vector2(paddlePosOffset, 150);
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

    //Get user preference on power-ups and obstacles
    bool powerUpsActive = await data.getPowerUpsStatus();
    bool obstaclesActive = await data.getObstaclesStatus();

    //Set ball and paddle speed and size
    double ballSpeed =
        await setBallSpeed(powerUpBallSpeedHit, obstacleBallSpeedHit);
    double paddleSpeed =
        await setPaddleSpeed(powerUpPaddleSpeedHit, obstaclePaddleSpeedHit);
    ball.size = await setBallSize(powerUpBallSizeHit, obstacleBallSizeHit);
    playerPaddle.size =
        await setPaddleLength(powerUpPaddleSizeHit, obstaclePaddleSizeHit);

    //Spawn power up if it doesn't exist and if they are enabled
    if (powerUpsActive == true) {
      _powerUpExists = await powerUpSpawner(_powerUpExists, size[0], size[1]);
    }

    //Spawn obstacle if it doesn't exist and if they are enabled
    if (obstaclesActive == true) {
      _obstacleExists =
          await obstacleSpawner(_obstacleExists, size[0], size[1]);
    }

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
    if (paddleHit) {
      if (ball.x < size.x / 2) {
        // hit in left half of the screen - comp
        ballXDirection = "right";
      } else {
        // hit in right half of the screen - player
        ballXDirection = "left";
        updateScore();
      }
      // Tap sound effect on-collision
      // To-Do: Find a way around being called multiple times per hit
      playTap();
    }

    if (ball.x < -ball.size[0] || ball.x > size[0]) {
      pauseEngine();
      overlays.add('GameOverOverlay');
      submit.retrieveData();
    }

    if (ball.y > size[1] - ball.size[1]) {
      ballYDirection = "up";
    }
    if (ball.y < 0) {
      ballYDirection = "down";
    }

    //Returns paddleHit back to false after the ball has hit the paddle so that the game can detect when the ball has passed a paddle after the first move.
    paddleHit = false;

    //Movement options for computer paddle
    switch (compDirection) {
      case "down":
        computerPaddle.y += ballSpeed;
        break;
      case "up":
        computerPaddle.y -= ballSpeed;
        break;
      case "stop":
        computerPaddle.y += 0;
    }

		//Computer Paddle Movement
		if (ballXDirection == "left") {
			// Ball is moving towards the computer paddle
			if (ball.y < computerPaddle.y + computerPaddle.height / 2) {
				compDirection = "up";
			} else if (ball.y > computerPaddle.y + computerPaddle.height / 2) {
				compDirection = "down";
			} else {
				compDirection = "stop";
			}
		} else {
			// Ball is moving away from the computer paddle
			compDirection = "stop";
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

    //Player Paddle edge detection
    if (playerPaddle.y > size[1] - playerPaddle.size.y) {
      playerDirection = "stop";
      playerPaddle.y = size[1] - playerPaddle.size.y;
    }
    if (playerPaddle.y < 0) {
      playerDirection = "stop";
      playerPaddle.y = 0;
    }

    //Power-Up Sprite Removal On Hit
    if (powerUpBallSpeedHit == true) {
      powerupballspeed.removeFromParent();
    }

    if (powerUpBallSizeHit == true) {
      powerupballsize.removeFromParent();
    }

    if (powerUpPaddleSpeedHit == true) {
      poweruppaddlespeed.removeFromParent();
    }

    if (powerUpPaddleSizeHit == true) {
      poweruppaddlesize.removeFromParent();
    }

    //Obstacle Sprite Removal On Hit
    if (obstacleBallSpeedHit == true) {
      obstacleballspeed.removeFromParent();
    }

    if (obstacleBallSizeHit == true) {
      obstacleballsize.removeFromParent();
    }

    if (obstaclePaddleSpeedHit == true) {
      obstaclepaddlespeed.removeFromParent();
    }

    if (obstaclePaddleSizeHit == true) {
      obstaclepaddlesize.removeFromParent();
    }
  }

  //Player movement code
  @override
  void onTapDown(TapDownInfo info) {
    var tapCoordinates = info.eventPosition.game;

    if (tapCoordinates.y > size[1] / 2) {
      playerDirection = "down";
    } else {
      playerDirection = "up";
    }
  }

  //Stop player paddle movement when user releases finger from screen
  @override
  void onTapUp(TapUpInfo info) {
    // todo sam: problem here..
    // if tapped and then drag flame will call onTapCancel immediately and never call onTapUp
    // because it thinks the user wants to drag and not tap
    // we still need to be able to handle the release to stop the paddle

    playerDirection = "stop";
  }
}
