

import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Ground extends PositionComponent{

  final Vector2 gridPosition;
  final Vector2 groundSize;


  Ground({required this.groundSize , required this.gridPosition});

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    position = gridPosition;
    size = groundSize;
    add(CircleHitbox());
    
    // TODO: implement onLoad
    return super.onLoad();
  }



}