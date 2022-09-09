import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/theme_provider.dart';
import 'package:provider/provider.dart';


class ChangeThemeButtonWidget extends StatelessWidget {

/*  var color_degisken1 = Colors.black;
  var color_degisken2 = Colors.white;
  var color_degisken3 = Colors.pink;
  */
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
/*        color_degisken3 = color_degisken1;
        color_degisken1 = color_degisken2;
        color_degisken2 = color_degisken3;

        setState(() {

        });*/

      },

    );
  }
}



