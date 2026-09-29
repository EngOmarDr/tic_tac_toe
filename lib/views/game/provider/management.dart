import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];
  List<String> gameList = List<String>.filled(9, '');

  String whoWillPlay = Player.playerX;
  String winner = Result.gameNotOver;

  Color getBackgroundColor(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.light &&
        whoWillPlay == Player.playerO) {
      return const Color(0xff283593);
    } else {
      return Theme.of(context).scaffoldBackgroundColor;
    }
  }

  Color getContainerColor(BuildContext context, int index) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Theme.of(context).splashColor;
    } else if (gameList[index] == 'O') {
      return Colors.blue;
    } else if (gameList[index] == 'X') {
      return Colors.red;
    } else {
      return Colors.white;
    }
  }

  String getText(int index) {
    if (gameList[index] == 'X') {
      return 'X';
    } else if (gameList[index] == 'O') {
      return 'O';
    } else {
      return '';
    }
  }

  Text getContainerText(BuildContext context, int index) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Text(getText(index),
          style: Theme.of(context).textTheme.bodyLarge!);
    } else if (gameList[index] == 'X') {
      return Text(getText(index),
          style: Theme.of(context).textTheme.bodyLarge!);
    } else {
      return Text(getText(index),
          style: Theme.of(context).textTheme.bodyMedium!);
    }
  }

  void pressedContainer(int index, BuildContext context) {
    if (gameList[index] == '') {
      gameList[index] = (whoWillPlay == Player.playerO) ? 'O' : 'X';
      whoWillPlay =
          whoWillPlay == Player.playerO ? Player.playerX : Player.playerO;
      getBackgroundColor(context);
      getContainerText(context, index);
      win(context);
      notifyListeners();
    }
  }

  void pressedContainerVsPhone(int index, BuildContext context) {
    if (gameList[index] == '') {
      gameList[index] = 'X';
      getBackgroundColor(context);
      getContainerText(context, index);
      win(context);
      notifyListeners();
    }
  }

  void win(BuildContext context) async {
    winner = checkWinner();
    if (winner != Result.draw && winner != Result.gameNotOver ||
        !gameList.contains('')) {
      await Future.delayed(const Duration(milliseconds: 200));
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) => AlertDialog(
          content: Text(winner),
          actions: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40)),
              onPressed: () async {
                gameList = List<String>.filled(9, '');
                winner = Result.gameNotOver;
                notifyListeners();
                Navigator.of(context).pop();
              },
              child: const Text("replay"),
            ),
          ],
        ),
      );
    }
  }

  String checkWinner() {
    for (var i = 0; i < winningConditions.length; i++) {
      if (gameList[winningConditions[i][0]] ==
              gameList[winningConditions[i][1]] &&
          gameList[winningConditions[i][0]] ==
              gameList[winningConditions[i][2]]) {
        if (gameList[winningConditions[i][2]] == 'X') {
          return Result.winnerX;
        } else if (gameList[winningConditions[i][2]] == 'O') {
          return Result.winnerO;
        }
      }
    }
    return gameList.contains('') ? Result.gameNotOver : Result.draw;
  }

  int winnerAsNumber(List gameList) {
    for (var i = 0; i < winningConditions.length; i++) {
      if (gameList[winningConditions[i][0]] ==
              gameList[winningConditions[i][1]] &&
          gameList[winningConditions[i][0]] ==
              gameList[winningConditions[i][2]]) {
        if (gameList[winningConditions[i][2]] == 'X') {
          return 2;
        } else if (gameList[winningConditions[i][2]] == 'O') {
          return -2;
        }
      }
    }
    return gameList.contains('') ? 1 : 0;
  }

  Future<int> minMax(int depth, bool isMaximizing, bool firstTime,
      BuildContext context) async {
    int result = winnerAsNumber(gameList);
    if (result != 1 || depth == 0) {
      return result;
    }
    if (isMaximizing) {
      int finalScore = -10;
      late int finalI;
      for (int i = 0; i < gameList.length; i++) {
        if (gameList[i] == '') {
          gameList[i] = 'X';
          int score = await minMax(depth - 1, false, false, context);
          gameList[i] = '';
          if (score > finalScore) {
            finalScore = score;
            finalI = i;
          }
          if (firstTime) {
            await Future.delayed(const Duration(seconds: 3));
            gameList[finalI] = 'X';
            win(context);
            notifyListeners();
          }
        }
      }
      return finalScore;
    } else {
      int finalScore = 10;
      late int finalI;
      for (int i = 0; i < gameList.length; i++) {
        if (gameList[i] == '') {
          gameList[i] = 'O';
          int score = await minMax(depth - 1, true, false, context);
          gameList[i] = '';
          if (score < finalScore) {
            finalScore = score;
            finalI = i;
          }
        }
      }
      if (firstTime) {
        await Future.delayed(const Duration(milliseconds: 150));
        gameList[finalI] = 'O';
        win(context);
        notifyListeners();
      }
      return finalScore;
    }
  }

  // @override
  // void dispose() {
  //   whoWillPlay = Player.playerX;
  //   gameList=List<String>.filled(9, '');
  //   super.dispose();
  // }
}

class Player {
  static String playerX = "play on X";
  static String playerO = "play on O";
}

class Result {
  static String winnerX = "Player X won";
  static String winnerO = "Player O won";
  static String draw = "Draw";
  static String gameNotOver = '';
}
