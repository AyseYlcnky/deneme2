import 'package:flutter/material.dart';
import 'package:news_app_api/views/contact.dart';
import 'package:news_app_api/views/homepage.dart';

import 'views/homepage.dart';
import 'helper/theme_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

final darkNotifier = ValueNotifier<bool>(false);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder:(context, _){
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeProvider.themeMode,
          theme:MyThemes.lightTheme,
          darkTheme:MyThemes.darkTheme,
          home: HomePage(
            title2: 'Homepage',
          ),
          routes: rotalar,
          debugShowCheckedModeBanner: false,
        );
      });
}

var rotalar = <String, WidgetBuilder> {
  "/contact": (BuildContext context) => contact(),
//  "/weather": (BuildContext context) => weather(),
};
