import 'package:flutter/material.dart';

@immutable
abstract class ThemeDataSource {
  Future<ThemeMode?> getThemeMode();
  Future<void> setThemeMode(ThemeMode themeMode);
  Future<Brightness?> getBrightness();
  Future<void> setBrightness(Brightness brightness);
}
