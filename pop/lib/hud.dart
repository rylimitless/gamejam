// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:pop/players/pink.dart';

// import 'pop.dart';


// class Hud extends PositionComponent with HasGameReference<PopGame> {

//   final Pink pink;

//   Hud({
//     required this.pink,
//     super.position,
//     super.size,
//     super.scale,
//     super.angle,
//     super.anchor,
//     super.children,
//     super.priority = 5,
//   });

//   late TextComponent _scoreTextComponent;

//   @override
//   Future<void> onLoad() async {
//     _scoreTextComponent = TextComponent(
//       text: 'PLAYER2 ${1+1}',
//       textRenderer: TextPaint(
//         style: const TextStyle(
//           fontSize: 20,
//           color: Color.fromRGBO(10, 10, 10, 1),
//         ),
//       ),
//       anchor: Anchor.center,
//       position: Vector2(game.size.x - 60, 20),
//     );
//     add(_scoreTextComponent);

//   }

//   @override
//   void update(double dt) {
//     _scoreTextComponent.text = '${pink.health}';
//   }
// }