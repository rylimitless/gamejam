import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'pop.dart';

void main() {
  runApp(
    const GameWidget<PopGame>.controlled(
      gameFactory: PopGame.new,
    ),
  );
}