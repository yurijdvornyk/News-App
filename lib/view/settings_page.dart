import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_news_app/blocs/settings_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

import '../constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  final _settingsBloc = SettingsBloc();
  /* Settings:
    - Light/dark theme // TODO: SwitchListTile
    - Country
    - Cache size
    - Open in build-in brower/use external?
    - Restore to defauts
  */

  List<Widget> get _content => [
        StreamBuilder(
            initialData: false,
            stream: _settingsBloc.useDarkThemeStream,
            builder: (context, AsyncSnapshot<bool> snapshot) {
              return ListTile(
                leading: Icon(Icons.brightness_5),
                title: Text("Use dark theme"),
                trailing: Switch(
                  value: snapshot.hasData ? snapshot.data : false,
                  onChanged: (value) => _settingsBloc.useDarkTheme(value),
                ),
              );
            }),
        StreamBuilder(
            initialData: SUPPORTED_COUNTRIES[0],
            stream: _settingsBloc.countryStream,
            builder: (context, AsyncSnapshot<String> snapshot) {
              return ListTile(
                  leading: Icon(Icons.map),
                  title: Text("Country"),
                  trailing: DropdownButton(
                      items: SUPPORTED_COUNTRIES
                          .map((country) => DropdownMenuItem(
                              key: Key(country),
                              value: country,
                              child: Text(country)))
                          .toList(),
                      value: snapshot.hasData ? snapshot.data : "UK",
                      onChanged: (value) => _settingsBloc.setCountry(value)));
            }),
        StreamBuilder(
            initialData: 20,
            stream: _settingsBloc.cacheSizeStream,
            builder: (context, AsyncSnapshot<int> snapshot) {
              int number = snapshot.hasData ? snapshot.data : 20;
              return ListTile(
                leading: Icon(Icons.memory),
                title: Text("Cache size"),
                trailing: Text(number.toString()),
                onTap: () => _showDialog(number),
              );
            })
      ];

  @override
  void initState() {
    super.initState();
    _settingsBloc.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _content);
  }

  void _showDialog(int cacheSize) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return new NumberPickerDialog.integer(
            minValue: 10,
            maxValue: 100,
            title: new Text("Select cache size"),
            initialIntegerValue: cacheSize,
          );
        }).then((int value) {
      if (value != null) {
        _settingsBloc.cacheSize(value);
      }
    });
  }

  @override
  void dispose() {
    _settingsBloc.dispose();
    super.dispose();
  }
}
