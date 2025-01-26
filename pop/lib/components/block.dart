import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pop/components/bullet.dart';
import 'package:pop/players/dude.dart';
import 'package:pop/players/pink.dart';

class BlockComponent extends PositionComponent with CollisionCallbacks {
  final Vector2 gridPosition;
  final Vector2 groundSize;

  BlockComponent({required this.groundSize, required this.gridPosition});

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    position = gridPosition;
    size = groundSize;
    
    // Make sure the hitbox is solid
    add(RectangleHitbox(
      collisionType: CollisionType.passive,  // Change to passive for solid blocks
      isSolid: true,  // Make the block solid
    ));
    
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      other.removeFromParent();
    }
    
    // // Handle collisions with players
    // if (other is Dude || other is Pink) {
    //   // You can add specific collision response here if needed
    //   final collision = intersectionPoints.first;
    //   // Push the player back
    //   other.position = other.position - (collision - other.position).normalized();
    // }
    
    super.onCollision(intersectionPoints, other);
  }

}