import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

/*Class which creates a Power Up Speed Sprite
  Position coordinates are passed into it when a Power Up Speed object is created*/
class PowerUpBallSize extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  PowerUpBallSize({
    Vector2? position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("PowerUpBallSize.png");
    size = Vector2(50, 50);
    add(CircleHitbox());
  }

  //Collision Detection between Ball and PowerUpSpeed
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      game.powerUpBallSizeHitBall(true);
    }
  }
}
