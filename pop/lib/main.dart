import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pop/overlays/game_over.dart';
import 'package:pop/overlays/main_menu.dart';

import 'pop.dart';

void main() {
  runApp(
    GameWidget<PopGame>.controlled(
      overlayBuilderMap: {
        'MainMenu' : ( _ ,game) => MainMenu(game: game),
        'GameOver' : ( _ ,game) => GameOver(game: game),
      },
      gameFactory: PopGame.new,
      initialActiveOverlays: ['MainMenu'],
    ),
  );
}