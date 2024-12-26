import 'package:flutter/material.dart';
import 'theme_repository.dart';
import 'theme_state.dart';

class ThemeStore extends ValueNotifier<ThemeState> {
  final ThemeRepository _repository;

  ThemeStore(this._repository) : super(const ThemeStateData()) {
    init();
  }

  Future<void> init() async {
    final themeMode = await _repository.getThemeMode();
    final brightness = await _repository.getBrightness();

    value = value.copyWith(
      themeMode: themeMode,
      brightness: brightness,
    );
  }

  ThemeMode get themeMode => value.themeMode!;

  set themeMode(ThemeMode themeMode) {
    if (themeMode == value.themeMode) {
      return;
    }

    _repository.setThemeMode(themeMode).then((_) {
      value = value.copyWith(
        themeMode: themeMode,
      );
    });
  }

  Brightness get brightness => value.brightness!;

  set brightness(Brightness brightness) {
    if (brightness == value.brightness) {
      return;
    }

    _repository.setBrightness(brightness).then((_) {
      value = value.copyWith(
        brightness: brightness,
      );
    });
  }
}
