import 'package:flutter/material.dart';

import 'package:pop/pop.dart';

class MainMenu extends StatelessWidget {
  // Reference to parent game.
  final PopGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(204, 26, 216, 1);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: 450,
          width: 450,
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
                'PoP',
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    game.overlays.remove('MainMenu');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteTextColor,
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: blackTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
'''In the mystical Air Kingdom, bubbles are both weapons and shields, and all seek the power of the Eternal Bubble. Warriors with unique bubble-based abilities battle fiercely to claim it, with defeated fighters vanishing in a dramatic pop. Only the strongest will rise as the ultimate Bubble Champion and rule the kingdom.''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height:20),
              const Text(
'''Player 1 uses W,A,D keys for movement and G key to attack.
Player 2 uses the Arrow keys for movement and Enter key to attack.''',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: whiteTextColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}