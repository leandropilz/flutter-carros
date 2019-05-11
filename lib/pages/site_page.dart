import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SitePage extends StatefulWidget {
  @override
  _SitePageState createState() => _SitePageState();
}

class _SitePageState extends State<SitePage> {
  var _showProgress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Site"),
        ), //AppBar
        body: _webView() //body
        ); //Scaffold
  }

  _webView() {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: WebView(
                initialUrl: "https://flutter.dev/",
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (request) {
                  return NavigationDecision.navigate;
                },
                onPageFinished: _onPageFinished,
              ), //WebView
            ), //Expanded
          ], //<Widget>[]
        ), //Column
        Opacity(
          opacity: _showProgress ? 1 : 0,
          child: Center(
            child: CircularProgressIndicator(), //CircularProgressIndicator
          ), //Center
        ), //Opacity
      ], //<Widget>[]
    ); //IndexedStack
  }

  void _onPageFinished(String url) {
    setState(() {
      _showProgress = false;
    });
  }
}
