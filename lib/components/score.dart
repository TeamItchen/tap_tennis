import 'package:flame/components.dart';
import 'package:tap_tennis/components/tap_tennis_game.dart' as game;

class Score extends TextComponent with HasGameRef<game.TapTennisGame> {
  late String score;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    score = game.score.toString();
    positionType = PositionType.viewport;
    text = score;

  }

  @override
  void update(double dt) {
    super.update(dt);
    score = game.score.toString();
    text = score;
  }
}
