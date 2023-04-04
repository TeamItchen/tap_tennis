import 'package:flame/components.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart';

class Score extends TextComponent with HasGameRef<TapTennisGame> {
  late String score;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    score = gameRef.score.toString();
    positionType = PositionType.viewport;
    text = score;

  }

  @override
  void update(double dt) {
    super.update(dt);
    score = gameRef.score.toString();
    text = score;
  }
}
