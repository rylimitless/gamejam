import 'dart:async';
import 'package:flame/components.dart';
import 'package:pop/pop.dart';

class BackgroundTile extends SpriteComponent with HasGameRef<PopGame> {
  final String color;
  BackgroundTile({this.color = 'Blue', position}) : super(position: position);

  final double scrollSpeed = 0.4;

  @override
  FutureOr<void> onLoad() {
    priority = -1;
    size = Vector2.all(64.6);
    sprite = Sprite(game.images.fromCache('Background/$color.png'));
    return super.onLoad();
  }

  @override
  void update(double dt) {
    position.y += scrollSpeed;
    double tileSize = 64;
    int scrollHeight = (game.size.y / tileSize).floor();
    if(position.y > scrollHeight * tileSize) position.y = -tileSize;
    super.update(dt);
  }
}