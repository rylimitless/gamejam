

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pop/components/bullet.dart';

class BlockComponent extends PositionComponent with CollisionCallbacks{

  final Vector2 gridPosition;
  final Vector2 groundSize;


  BlockComponent({required this.groundSize , required this.gridPosition});

  @override
  FutureOr<void> onLoad() {
    debugMode = false;
    position = gridPosition;
    size = groundSize;
    
    add(RectangleHitbox(collisionType: CollisionType.active));
    
    // TODO: implement onLoad
    return super.onLoad();
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Bullet){
      other.removeFromParent();
    }
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
  }



}