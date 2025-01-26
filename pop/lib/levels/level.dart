import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pop/components/block.dart';
import 'package:pop/components/ceiling.dart';
import 'package:pop/components/ground.dart';

class Level extends World{

  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    // final obstacleGroup = level.tileMap.getLayer<ObjectGroup>('boarder');
    final blockGroup = level.tileMap.getLayer<ObjectGroup>('blocks');

    // final CeilingGroup = level.tileMap.getLayer<ObjectGroup>('ceiling');

    // for (final obj in obstacleGroup!.objects){
    //   add(Ground(groundSize: Vector2(obj.width, obj.height), gridPosition: Vector2(obj.x, obj.y)));
    // }

    // for (final obj in CeilingGroup!.objects){
    //   add(Ceiling(groundSize: Vector2(obj.width,obj.height), gridPosition: Vector2(obj.x, obj.y)));
    // }

    for (final obj in blockGroup!.objects){
      add(BlockComponent(groundSize: Vector2(obj.width,obj.height), gridPosition: Vector2(obj.x, obj.y)));
    }

    add(level);
    return super.onLoad();
  }
}