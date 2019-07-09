import 'dart:async';

import 'package:global_news_app/blocs/base_bloc.dart';
import 'package:global_news_app/resources/settings_repository.dart';

class SettingsBloc implements BaseBloc {
  final _repository = SettingsRepository();

  final _useDarkThemeController = StreamController<bool>.broadcast();
  get useDarkThemeStream => _useDarkThemeController.stream;

  final _countryController = StreamController<String>.broadcast();
  get countryStream => _countryController.stream;

  final _cacheSizeController = StreamController<int>.broadcast();
  get cacheSizeStream => _cacheSizeController.stream;

  final _useExternalBrowserController = StreamController<bool>.broadcast();
  get useExternalBrowserStream => _useExternalBrowserController.stream;

  useDarkTheme(bool use) {
    _repository
        .shouldUseDarkTheme(use)
        .then((value) => _useDarkThemeController.sink.add(value));
  }

  setCountry(String country) {
    _repository
        .setCountry(country)
        .then((value) => _countryController.sink.add(value));
  }

  cacheSize(int cacheSize) {
    _repository
        .setCacheSize(cacheSize)
        .then((value) => _cacheSizeController.sink.add(value));
  }

  loadSettings() {
    _repository.useDarkTheme
        .then((value) => _useDarkThemeController.sink.add(value));
    _repository.country.then((value) => _countryController.sink.add(value));
    _repository.cacheSize
        .then((value) => _cacheSizeController.sink.add(value));
  }

  @override
  void dispose() {
    _useDarkThemeController.close();
    _countryController.close();
    _cacheSizeController.close();
    _useExternalBrowserController.close();
  }
}

final settingsBloc = SettingsBloc();