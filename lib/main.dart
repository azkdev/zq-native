import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset() async {
  return await rootBundle.loadString('assets/my_text.txt');
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWebView(),
    );
  }
}

class MyWebView extends StatefulWidget {
  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  String site = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadAsset().then((val) {
      setState(() {
        site = val;
      });
    });
    return site != ""
        ? Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: WebviewScaffold(
              url: site,
              bottomNavigationBar: BottomNavigationBar(
                iconSize: 16.0,
                currentIndex: 0, // this will be set when a new tab is tapped
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_back),
                    title: Text("Back"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard),
                    title: Text("Dashboard"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.refresh),
                    title: Text("Refresh"),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
