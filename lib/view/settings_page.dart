import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/data/settings_helper.dart';
import 'progress_view.dart';
import 'package:numberpicker/numberpicker.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  bool _useDarkTheme;
  String _country;
  int _cacheSize;
  bool _useExternalBrowser;

  bool get _isLoaded =>
      _useDarkTheme != null &&
      _country != null &&
      _cacheSize != null &&
      _useExternalBrowser != null;

  /* Settings:
    - Light/dark theme // TODO: SwitchListTile
    - Country
    - Cache size
    - Open in build-in brower/use external?
    - Restore to defauts
  */

  List<Widget> get _content => [
        ListTile(
          leading: Icon(Icons.brightness_5),
          title: Text("Use dark theme"),
          trailing: Switch(
            value: _useDarkTheme,
            onChanged: (value) {
              SettingsHelper.instance.shouldUseDarkTheme(value);
              setState(() {
                _useDarkTheme = value;
              });
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text("Country"),
          trailing: DropdownButton(onChanged: (value) {
            SettingsHelper.instance.setCountry(value);
            _country = value;
          }),
        ),
        ListTile(
          leading: Icon(Icons.memory),
          title: Text("Cache size"),
          trailing: Text("20"),
          onTap: () => _showDialog(),
        )
      ];

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded) {
      return ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: Colors.black, height: 0),
        itemCount: _content.length,
        itemBuilder: (BuildContext context, int index) {
          return _content[index];
        },
      );
    } else {
      return progressIndicator;
    }
  }

  void loadSettings() {
    if (mounted) {
      SettingsHelper.instance.settings.then((settingsMap) {
        setState(() {
          _useDarkTheme =
              settingsMap[SettingsHelper.KEY_USE_DARK_THEME] ?? false;
          _country = settingsMap[SettingsHelper.KEY_COUNTRY] ?? "US";
          _cacheSize = settingsMap[SettingsHelper.KEY_CACHE_SIZE] ?? 20;
          _useExternalBrowser =
              settingsMap[SettingsHelper.KEY_USE_EXTERNAL_BROWSER] ?? true;
        });
      });
    }
  }

  void _showDialog() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 10,
            maxValue: 100,
            title: new Text("Select cache size"),
            initialIntegerValue: _cacheSize,
          );
        }).then((int value) {
      if (value != null) {
        setState(() => _cacheSize = value);
      }
    });
  }
}
