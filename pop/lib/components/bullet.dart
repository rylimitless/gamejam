
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:pop/pop.dart';

class Bullet extends SpriteAnimationComponent
    with HasGameReference<PopGame> {
  Bullet({
    super.position,
  }) : super(
          size: Vector2(25, 50),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('bubbleball1.png'),
      SpriteAnimationData.sequenced(amount: 4, stepTime: 1, textureSize: Vector2.all(32)));
  }

   @override
  void update(double dt) {
    super.update(dt);

    position.x += dt * -500;

    if (position.x < -width) {
      removeFromParent();
    }
  }
}