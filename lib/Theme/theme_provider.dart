import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLight = false;
  ThemeMode themeMode = ThemeMode.dark;

  void changeTheme() {
    isLight = !isLight;
    themeMode = isLight ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  ThemeData typeTheme() {
    return isLight ? lightTheme : darkTheme;
  }

  ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xffb71c1c),
      appBarTheme:
          const AppBarTheme(backgroundColor: Color(0xffb71c1c), elevation: 0),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ),
      ));

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff00161a),
    appBarTheme:
        const AppBarTheme(backgroundColor: Color(0xff00161a), elevation: 0),
    textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
        bodyMedium: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w400,
          color: Colors.blue,
        ),
        displayLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        )),
  );
}
