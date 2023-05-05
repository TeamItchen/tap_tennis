import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:tap_tennis/components/ball.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

class PowerUpPortal extends SpriteComponent
    with HasGameRef<TapTennisGame>, CollisionCallbacks {
  PowerUpPortal({
    Vector2? position,
  }) : super(position: position) {
    debugMode = true;
  }
  var portal = false;

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite("Portal.png");
    size = Vector2(50, 50);
    add(CircleHitbox());
  }

  //Collision Detection between Ball and PowerUpSpeed
  @override
  void onCollision(intersectionPoints, other) {
    super.onCollision(intersectionPoints, other);
    if (other is Ball) {
      game.placePortal(true, portal);
    }
  }
}
