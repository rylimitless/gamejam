import 'dart:async';
import 'dart:ui';

import 'package:flame/game.dart';
import 'package:pop/levels/level.dart';
import 'package:flame/components.dart';

class Pop extends FlameGame {
  
  @override 
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;
  @override
  final world = Level();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await images.loadAll([
      'Background/Gray.png',
      'Background/Blue.png',
      'Background/Purple.png',
      'Background/Brown.png',
      // Add other background images here
    ]);

    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);
  }
}