import 'package:flutter/material.dart';
import 'package:pop/pop.dart';

class GameOver extends StatelessWidget {
  // Reference to parent game.
  final PopGame game;
  const GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(204, 26, 216, 1);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 200,
          width: 300,
          decoration: const BoxDecoration(
            color: blackTextColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 40),
            // Image.asset(
            //   'assets/images/weapons/eternalbubble.png',
            //   width: 100,
            //   height: 100,
            // ),

            //   SizedBox(
            //     width: 200,
            //     height: 75,
            //     child: ElevatedButton(
            //       onPressed: () {
            //         game.reset();
                    
            //         game.overlays.remove('GameOver');

            //       },
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor: whiteTextColor,
            //       ),
            //       child: const Text(
            //         'Play Again',
            //         style: TextStyle(
            //           fontSize: 28.0,
            //           color: blackTextColor,
            //         ),
            //       ),
            //     ),
            //   ),
            ],
          ),
        ),
      ),
    );
  }
}