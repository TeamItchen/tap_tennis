import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

/*Class which creates a Paddle Sprite
  Position coordinates are passed into it when a Paddle object is created*/
class Paddle extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  Paddle({
    Vector2? position,
  }) : super(position: position) {
    debugMode = true;
  }

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("Paddle.png");
    size = Vector2(25, 100);
    add(RectangleHitbox());
  }

  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      print("Screen Hit");
    }
  }
}
