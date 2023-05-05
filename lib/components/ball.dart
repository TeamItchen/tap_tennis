import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/paddle.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

//Class which creates a Ball Sprite
//Position coordinates are passed into it when object is created
class Ball extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  Ball({
    Vector2? position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("Ball.png");
    size = Vector2(25, 25);
    add(CircleHitbox());
  }

//Collision Detection between Ball and Paddle
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Paddle) {
      //print("Paddle Hit");
      game.paddleHitBall(true);
    }
  }
}
