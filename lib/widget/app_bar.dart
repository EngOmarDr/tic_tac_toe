import 'package:flutter/material.dart';
import 'package:tic_tac_toe/Theme/theme_provider.dart';

AppBar appBar(Color backColor,ThemeProvider themData){
  return AppBar(
    backgroundColor: backColor,
    actions: [
      const SizedBox(width: 15),
      IconButton(
          icon: Icon(
              themData.isLight ? Icons.light_mode : Icons.dark_mode),
          onPressed: () {
            themData.changeTheme();
          }),
    ],
  );
}