import 'package:flutter/material.dart';
import 'package:global_news_app/constants.dart';
import 'blocs/settings_bloc.dart';
import 'view/home_page.dart';

void main() => runApp(GlobalNewsApp());

class GlobalNewsApp extends StatefulWidget {
  // TODO: Add location service; set current country as default

  @override
  State<StatefulWidget> createState() {
    return _GlobalNewsAppState();
  }
}

class _GlobalNewsAppState extends State<GlobalNewsApp> {

  //final _settingsBloc = SettingsBloc();

  @override
  void initState() {
    super.initState();
    settingsBloc.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: false,
        stream: settingsBloc.useDarkThemeStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          var theme = snapshot.hasData ? (snapshot.data ? appDarkTheme : appLightTheme) : appDefaultTheme;
          return MaterialApp(
              theme: theme,
              home: HomePage());
        });
  }
}

/*
LINKS:
News API: https://newsapi.org
Bottom navigation: https://willowtreeapps.com/ideas/how-to-use-flutter-to-build-an-app-with-bottom-navigation
Swipe to refresh: https://medium.com/flutterpub/adding-swipe-to-refresh-to-flutter-app-b234534f39a7
Database: https://flutter.dev/docs/cookbook/persistence/sqlite
Database: https://medium.com/@studymongolian/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
Dynamic themes: https://medium.com/@frmineoapps/flutter-how-to-change-the-apps-theme-dynamically-using-streams-77df0c7b0c16
TODO: Bloc Pattern!!! https://medium.com/@frmineoapps/flutter-bloc-pattern-and-a-little-medical-app-992b189d5124
BLOC: https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1
About streams: https://medium.com/flutter-community/reactive-programming-streams-bloc-6f0d2bd2d248
*/
