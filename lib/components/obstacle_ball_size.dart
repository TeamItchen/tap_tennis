import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

//Class which creates an Obstacle Ball Size Sprite
//Position coordinates are passed into it when object is created
class ObstacleBallSize extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  ObstacleBallSize({
    Vector2? position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("ObstacleBallSize.png");
    size = Vector2(50, 50);
    add(CircleHitbox());
  }

  //Collision Detection between Ball and Obstacle
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      game.obstacleBallSizeHitBall(true);
    }
  }
}
