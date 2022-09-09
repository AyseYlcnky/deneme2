import 'package:flutter/material.dart';
import 'package:news_app_api/helper/change_theme_button_widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helper/theme_provider.dart';

class sideMenu extends StatelessWidget {
  const sideMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/logo_f2_preview_rev_1.png',
                width: 150.0,
                height: 150.0,
              ),
            ),

            Expanded(
              child: ListView(
                children: <Widget>[

                  ExpansionTile(
                    leading: Icon(Icons.account_box),
                    title: Text('ABOUT US'),
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: ListTile(
                          leading: Icon(Icons.supervised_user_circle),
                          title: Text("Get To Know Us"),
                          onTap: () {
                            Navigator.pop(context);
                            _urlOpen("https://www.winnovadanismanlik.com/hakkimizda/");
                          },//alt çizgi bu class'ın içinde kullanabilecegimi gostermek için
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 5.0,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    leading: Icon(Icons.contact_phone),
                    title: Text('CONTACT'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context,'/contact');
                    },
                  ),

                  Divider(
                    height: 10.0,
                    color: Colors.blueGrey,
                  ),
                  ExpansionTile(
                      leading: Icon(Icons.settings_suggest),
                      title: Text('SETTINGS'),
                      children:<Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(themeProvider.isDarkMode ? Icons.wb_sunny : Icons.bedtime),

                                onPressed: () {
                                  final provider = Provider.of<ThemeProvider>(context, listen: false);
                                  provider.toggleTheme(themeProvider.isDarkMode ? false : true);
                                },
                              ),
                              Text("Theme Mode"),
                            ],
                          ),
                       ),
                     ],

                  ),

                  Divider(
                    height: 10.0,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future _urlOpen(String link) async{
  if(await canLaunch(link)) { //gelen linki ktrol et eger calisiyosa true donerse
    await launch(link); //gönderdiğim linki çalıştır
  } else {
    debugPrint("I can't open the link you sent");
  }
}