import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/Theme/theme_provider.dart';
import 'package:tic_tac_toe/views/game/provider/management.dart';
import 'package:tic_tac_toe/widget/app_bar.dart';

class Game extends StatelessWidget {
  final bool vsPlayer;

  const Game({Key? key, required this.vsPlayer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<GameProvider, ThemeProvider>(
      builder: (_, gameData, themData, __) {
        return Scaffold(
          backgroundColor: gameData.getBackgroundColor(context),
          appBar: appBar(gameData.getBackgroundColor(context), themData),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.read<GameProvider>().whoWillPlay,
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(height: 30),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  9,
                  (index) => GestureDetector(
                    onTap: () {
                      if (vsPlayer) {
                        Provider.of<GameProvider>(context, listen: false)
                            .pressedContainer(index, context);
                      } else {
                        context
                            .read<GameProvider>()
                            .pressedContainerVsPhone(index, context);
                        context
                            .read<GameProvider>()
                            .minMax(8, false, true, context);
                      }
                    },
                    child: Consumer<GameProvider>(
                      builder: (_, data, __) {
                        return AnimatedContainer(
                          alignment: Alignment.center,
                          child: data.getContainerText(context, index),
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              color: data.getContainerColor(context, index),
                              borderRadius: BorderRadius.circular(15)),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
