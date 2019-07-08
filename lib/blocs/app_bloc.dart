import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_news_app/blocs/base_bloc.dart';
import 'package:global_news_app/constants.dart';

// class AppBloc implements BaseBloc {
//   final _themeController = StreamController<ThemeData>();
//   get themeStream => _themeController.stream;

//   changeTheme(bool useDarkTheme) {
//     _themeController.sink.add(await SettingsHelper.instance.useDarkTheme
//         ? appDarkTheme
//         : appLightTheme);
//   }

//   dispose() {
//     _themeController.close();
//   }
// }

// final appBloc = AppBloc();