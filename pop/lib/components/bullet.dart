
import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:pop/pop.dart';

enum Player {A , B}

class Bullet extends SpriteAnimationComponent with HasGameReference<PopGame> {
  final double direction;
  final double speed = 500;
  final Player player;

  Bullet({
    required this.player,
    required super.position,
    this.direction = 1.0,  // Default direction is right
  }) : super(
    size: Vector2(25, 50),
    anchor: Anchor.bottomCenter,
  );

  @override
  Future<void> onLoad() async {
    size = Vector2.all(8);
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('block.png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.5,
        textureSize: Vector2.all(16),
      ),
    );
    
    add(RectangleHitbox(priority: debugCoordinatesPrecision));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += dt * speed * direction;  // Use direction for movement

    if (position.x < -width || position.x > game.size.x) {
      removeFromParent();
    }
  }
}