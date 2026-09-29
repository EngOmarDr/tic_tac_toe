import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/Theme/theme_provider.dart';
import 'package:tic_tac_toe/views/start_page/start_page.dart';

import 'views/game/provider/management.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, data, __) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: data.themeMode,
              theme: data.typeTheme(),
              home: const StartPage());
        },
      ),
    );
  }
}
