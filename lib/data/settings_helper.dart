import 'package:shared_preferences/shared_preferences.dart';

class SettingsHelper {
  static final SettingsHelper instance = SettingsHelper._privateConstructor();

  static const KEY_USE_DARK_THEME = "use_dak_theme";
  static const KEY_COUNTRY = "country";
  static const KEY_CACHE_SIZE = "cache_size";
  static const KEY_USE_EXTERNAL_BROWSER = "use_external_browser";

  static const _defaults = {
    KEY_USE_DARK_THEME: false,
    KEY_COUNTRY: "US",
    KEY_CACHE_SIZE: 20,
    KEY_USE_EXTERNAL_BROWSER: true
  };

  SettingsHelper._privateConstructor();

  Future<bool> get useDarkTheme async => await SharedPreferences.getInstance()
      .then((preferences) => preferences.getBool(KEY_USE_DARK_THEME));
  
  Future<bool> shouldUseDarkTheme(bool shouldUse) async =>
      await SharedPreferences.getInstance()
          .then((preferences) => preferences.setBool(KEY_USE_DARK_THEME, shouldUse))
          .then((success) => shouldUse);

  Future<String> get country async => await SharedPreferences.getInstance()
      .then((preferences) => preferences.getString(KEY_COUNTRY));

  Future<String> setCountry(String country) async =>
    await SharedPreferences.getInstance()
          .then((preferences) => preferences.setString(KEY_COUNTRY, country))
          .then((success) => country);
  
  Future<int> get cacheSize async => await SharedPreferences.getInstance()
      .then((preferences) => preferences.getInt(KEY_CACHE_SIZE));

  Future<int> setCacheSize(int size) async =>
    await SharedPreferences.getInstance()
          .then((preferences) => preferences.setInt(KEY_CACHE_SIZE, size))
          .then((success) => size);

  Future<bool> get useExternalBrowser async => await SharedPreferences.getInstance()
      .then((preferences) => preferences.getBool(KEY_USE_EXTERNAL_BROWSER));
  
  Future<bool> shoulduseExternalBrowser(bool shouldUse) async =>
      await SharedPreferences.getInstance()
          .then((preferences) => preferences.setBool(KEY_USE_EXTERNAL_BROWSER, shouldUse))
          .then((success) => shouldUse);

  Future<Map<String, Object>> get settings async => {
    KEY_USE_DARK_THEME: await useDarkTheme,
    KEY_COUNTRY: await country,
    KEY_CACHE_SIZE: await cacheSize,
    KEY_USE_EXTERNAL_BROWSER: await useExternalBrowser
  };

  Future<Null> restoreDefaults() async =>
    await SharedPreferences.getInstance()
      .then((preferences) {
        preferences.setBool(KEY_USE_DARK_THEME, _defaults[KEY_USE_DARK_THEME]);
        preferences.setString(KEY_COUNTRY, _defaults[KEY_COUNTRY]);
        preferences.setInt(KEY_CACHE_SIZE, _defaults[KEY_CACHE_SIZE]);
        preferences.setBool(KEY_USE_EXTERNAL_BROWSER, _defaults[KEY_USE_EXTERNAL_BROWSER]);
      });
}
