import 'package:flutter/material.dart';

const String NEWS_API_KEY = "ff6270bb2fc242ef9bb200a150cc4584";
const SUPPORTED_COUNTRIES = ["UK", "US", "DE", "FR", "NO", "SE"];
ThemeData appLightTheme = ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue);
ThemeData appDarkTheme = ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue);
ThemeData appDefaultTheme = appLightTheme;