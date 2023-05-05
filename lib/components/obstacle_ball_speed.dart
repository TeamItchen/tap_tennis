import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

//Class which creates an Obstacle Ball Speed Sprite
//Position coordinates are passed into it when object is created
class ObstacleBallSpeed extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  ObstacleBallSpeed({
    Vector2? position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("ObstacleBallSpeed.png");
    size = Vector2(50, 50);
    add(CircleHitbox());
  }

  //Collision Detection between Ball and Obstacle
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      game.obstacleBallSpeedHitBall(true);
    }
  }
}
