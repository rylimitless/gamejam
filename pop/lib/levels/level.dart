import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:pop/background_tile.dart';
import 'package:pop/components/block.dart';
import 'package:pop/pop.dart';

class Level extends World with HasGameRef<PopGame> {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));
    add(level);
    _scrollingBackground();
    return super.onLoad();
  }

  void _scrollingBackground() {
    final backgroundLayer = level.tileMap.getLayer('Backgrounds');
    const tileSize = 64;

    final numTilesY = (game.size.y / tileSize).floor();
    final numTilesX = (game.size.x / tileSize).floor();

     final blockGroup = level.tileMap.getLayer<ObjectGroup>('block');

    for (final obj in blockGroup!.objects){
      add(BlockComponent(groundSize: Vector2(obj.width,obj.height), gridPosition: Vector2(obj.x, obj.y)));
    }

    if (backgroundLayer != null) {
      final backgroundColor = backgroundLayer.properties.getValue('BackgroundColor') ?? 'Blue';

      for (double y = 0; y < game.size.y / numTilesY; y++) {
        for (double x = 0; x < numTilesX; x++) {
          final backgroundTile = BackgroundTile(
            color: backgroundColor,
            position: Vector2(x * tileSize, y * tileSize),
          );
          add(backgroundTile);
        }
      }
    }
  }
}