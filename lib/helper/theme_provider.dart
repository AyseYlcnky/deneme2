import 'package:flutter/material.dart';



class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
      textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold)
      ),
      appBarTheme: AppBarTheme(backgroundColor: Colors.brown),
  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    textTheme: const TextTheme(
        bodyText1: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.bold)
    )

  );

}