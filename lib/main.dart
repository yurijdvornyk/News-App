import 'package:flutter/material.dart';

import 'view/home_page.dart';

void main() => runApp(GlobalNewsApp());

class GlobalNewsApp extends StatelessWidget {

  // TODO: Add location service; set current country as default

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global News App',
      theme: ThemeData.light(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomePage(),
    );
  }
}

/*
LINKS:
News API: https://newsapi.org
Bottom navigation: https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
Swipe to refresh: https://medium.com/flutterpub/adding-swipe-to-refresh-to-flutter-app-b234534f39a7
Database: https://flutter.dev/docs/cookbook/persistence/sqlite
Database: https://medium.com/@studymongolian/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
*/