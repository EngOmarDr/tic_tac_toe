import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/Theme/theme_provider.dart';
import 'package:tic_tac_toe/views/game/game.dart';
import 'package:tic_tac_toe/views/game/provider/management.dart';
import 'package:tic_tac_toe/widget/app_bar.dart';
import 'package:tic_tac_toe/widget/custom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, GameProvider>(
      builder: (_, themData, gameData, __) => Scaffold(
        backgroundColor: gameData.getBackgroundColor(context),
        appBar: appBar(gameData.getBackgroundColor(context), themData),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              paddingHorizontal: 50,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Game(vsPlayer: true))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.person, color: Colors.white, size: 30),
                  Text(
                    'VS',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Icon(Icons.person, color: Colors.white, size: 30),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CustomButton(
              paddingHorizontal: 50,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Game(vsPlayer: false))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.person, color: Colors.white, size: 30),
                  Text(
                    'VS',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const Icon(Icons.phone_android,
                      color: Colors.white, size: 30),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
