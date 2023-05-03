import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

/*Class which creates a Power Up Length Sprite
  Position coordinates are passed into it when a Power Up Length object is created*/
class PowerUpLength extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  PowerUpLength({
    Vector2? position,
  }) : super(position: position) {
    debugMode = true;
  }

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("PowerUpLength.png");
    size = Vector2(75, 75);
    add(CircleHitbox());
  }

  //Collision Detection between Ball and PowerUpSpeed
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      game.powerUpLengthHitBall(true);
    }
  }
}
