import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app_api/helper/change_theme_button_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String postUrl;

  ArticleView({@required this.postUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) { //ana sayfadan gidilen haberler
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset('assets/yan_logo2.png'),
        ),
        actions: <Widget>[
          ChangeThemeButtonWidget(),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.share,
              ))
        ],
        backgroundColor: Colors.brown,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WebView(
          initialUrl: widget.postUrl,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
