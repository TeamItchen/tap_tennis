import 'package:flame/components.dart';

/*Class which creates a Paddle Sprite
  Position coordinates are passed into it when a Paddle object is created*/
class Paddle extends SpriteComponent with HasGameRef {
  Paddle({
    required Vector2 position,
  }) : super(position: position);

//Method setting the image file and size of sprite
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite("Paddle.png");
    size = Vector2(100, 100);
  }
}
