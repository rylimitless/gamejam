import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:pop/pop.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
    Flame.device.fullScreen();
    Flame.device.setLandscape();

  Pop game = Pop();
  runApp(GameWidget(game: kDebugMode ? Pop() : game));
}

