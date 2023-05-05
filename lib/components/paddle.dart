import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';


//Class which creates a Paddle Sprite
//Position coordinates are passed into it when object is created
class Paddle extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  Paddle({
    Vector2? position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("Paddle.png");
    size = Vector2(25, 100);
    add(RectangleHitbox());
  }
}
