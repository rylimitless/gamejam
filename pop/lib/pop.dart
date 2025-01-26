import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:pop/hud.dart';
import 'package:pop/players/dude.dart';
import 'package:pop/players/pink.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:pop/levels/level.dart';


class PopGame extends FlameGame with HasKeyboardHandlerComponents , HasCollisionDetection{

@override 
  Color backgroundColor() => const Color(0xFF211F30);

  late final CameraComponent cam;

  @override
  final world = Level();


    @override
  FutureOr<void> onLoad() async {
   await Flame.images.loadAll([
      "block.png",
      "pink.png",
      "sprites/Pink_Monster/Pink_Monster_Attack1_4.png",
      "sprites/Pink_Monster/Pink_Monster_Run_6.png",
      "sprites/Pink_Monster/Pink_Monster_Jump_8.png",
      // "Pink_Monster6.png",
      "weapons/bubbleball.png",
      "sprites/Dude_Monster/Dude_Monster_Idle_4.png",
      "sprites/Dude_Monster/Dude_Monster_Attack1_4.png",
      "sprites/Dude_Monster/Dude_Monster_Run_6.png",
      "sprites/Dude_Monster/Dude_Monster_Jump_8.png",
      "bubbleball1.png",
      'Background/Gray.png',
      'Background/Blue.png',
      'Background/Purple.png',
      'Background/Brown.png',
    
    ]);

     cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;

    camera.viewfinder.anchor = Anchor.topLeft;


    addAll([cam, world]);



var _pink = Pink(world: world)
    ..position = Vector2(320, 180)
    ..debugMode = true; // Enable debug mode for Pink
  world.add(_pink);

    camera.viewport.add(Hud(pink: _pink));


    var _dude = Dude(world: world)..position = Vector2(165 , 80);
    world.add(_dude);
    // TODO: implement onLoad
    return super.onLoad();

  }
}