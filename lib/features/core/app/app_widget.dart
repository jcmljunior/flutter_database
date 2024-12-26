import 'package:flutter/material.dart';
import '../../sqflite/sqflite_theme_data_source.dart';
// import '../../shared_preferences/shared_preferences_data_source.dart';
// import '../../shared_preferences/shared_preferences_theme_repository.dart';
import '../../sqflite/sqflite_theme_repository.dart';
import '../localization/localization_manager.dart';
import '../localization/localization_state.dart';
import '../localization/localization_store.dart';
import '../theme/theme_manager.dart';
import '../theme/theme_store.dart';
import 'home_page.dart';

@immutable
class AppWidget extends StatelessWidget {
  final LocalizationStore _localizationStore =
      LocalizationStore(LocalizationStateData());
  // Implementação de SharedPreferences.
  // final ThemeStore _themeStore = ThemeStore(
  //     SharedPreferencesThemeRepository(SharedPreferencesDataSource()));
  // Implementação de Sqlite.
  final ThemeStore _themeStore =
      ThemeStore(SqfliteThemeRepository(SqfliteThemeDataSource()));

  AppWidget({
    super.key,
  });

  Brightness getBrightness(BuildContext context) {
    final ThemeMode themeMode = _themeStore.themeMode;

    switch (themeMode) {
      case ThemeMode.light:
        return Brightness.light;
      case ThemeMode.dark:
        return Brightness.dark;
      default:
        return View.of(context).platformDispatcher.platformBrightness;
    }
  }

  void syncPlatformBrightness(BuildContext context) {
    if (_themeStore.themeMode != ThemeMode.system) {
      return;
    }

    _themeStore.brightness =
        View.of(context).platformDispatcher.platformBrightness;
  }

  @override
  Widget build(BuildContext context) {
    return LocalizationManager(
      store: _localizationStore,
      child: ThemeManager(
        store: _themeStore,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _localizationStore,
            _themeStore,
          ]),
          builder: (BuildContext context, Widget? _) {
            syncPlatformBrightness(context);
            WidgetsBinding
                    .instance.platformDispatcher.onPlatformBrightnessChanged =
                () => syncPlatformBrightness(context);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: _themeStore.themeMode,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.blue,
                  brightness: getBrightness(context),
                ),
              ),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
