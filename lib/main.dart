import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sos Drôles de Dames',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sos Drôles de Dames'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  Completer<WebViewController> _controllerCompleter = Completer<WebViewController>();

  WebViewController _controller;

  Future<void> _handleBack(context) async {
    var status = await _controller.canGoBack();
    if (status) {
      _controller.goBack();
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Êtes-vous sûr de vouloir quitter ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('NON'),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text('OUI'),
              ),
            ],
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      WillPopScope(
        onWillPop: () => _handleBack(context),
        child : Container(
          color: Colors.pinkAccent,
          child : SafeArea(
            child : WebView(
              initialUrl: 'http://sosdrolesdedames.fr/',
                onWebViewCreated: (WebViewController webViewController) {
                  _controllerCompleter.future.then((value) => _controller = value);
                  _controllerCompleter.complete(webViewController);
                },
            ),
          ),
        ),
      ),
    );
  }
}

