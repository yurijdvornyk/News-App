import 'dart:async';
import 'package:flutter/material.dart';
import 'package:global_news_app/constants.dart';

import 'data/settings_helper.dart';

class AppBloc {
  final _themeController = StreamController<ThemeData>();
  get themeStream => _themeController.stream;

  changeTheme(bool useDarkTheme) async {
    ThemeData theme = await SettingsHelper.instance.useDarkTheme
        ? APP_DARK_THEME
        : APP_LIGHT_THEME;
    _themeController.sink.add(theme);
  }

  // dispose() {
  //   _themeController.close();
  // }
}

final appBloc = AppBloc();
