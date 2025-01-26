

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BlockComponent extends PositionComponent{

  final Vector2 gridPosition;
  final Vector2 groundSize;


  BlockComponent({required this.groundSize , required this.gridPosition});

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    position = gridPosition;
    size = groundSize;
    
    add(RectangleHitbox(collisionType: CollisionType.active));
    
    // TODO: implement onLoad
    return super.onLoad();
  }



}