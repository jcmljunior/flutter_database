import 'package:flutter/material.dart';
import '../core/theme/theme_data_source.dart';
import 'sqflite_service.dart';

@immutable
class SqfliteThemeDataSource implements ThemeDataSource {
  @override
  Future<Brightness?> getBrightness() async {
    final db = SqfliteService();
    final result = await db
        .select()
        .from('theme_config')
        .where('name', 'brightness')
        .execute();

    if (result != null && result.isNotEmpty) {
      return Brightness.values.elementAt(
        int.parse(result.elementAt(0)['value'].toString()),
      );
    }

    return null;
  }

  @override
  Future<ThemeMode?> getThemeMode() async {
    final db = SqfliteService();
    final result = await db
        .select()
        .from('theme_config')
        .where('name', 'themeMode')
        .execute();

    if (result != null && result.isNotEmpty) {
      return ThemeMode.values.elementAt(
        int.parse(result.elementAt(0)['value'].toString()),
      );
    }

    return null;
  }

  @override
  Future<void> setBrightness(Brightness brightness) async {
    final db = SqfliteService();
    final Map<String, String> data = {
      'name': 'brightness',
      'value': brightness.index.toString(),
    };
    final Brightness? brightnessDb = await getBrightness();

    // Se existir o brightness no banco de dados, atualiza, senao insere.
    if (brightnessDb != null) {
      await db
          .update('theme_config', data)
          .where('name', data['name'])
          .execute();
    } else {
      await db.insert('theme_config', data).execute();
    }
  }

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    final db = SqfliteService();
    final Map<String, String> data = {
      'name': 'themeMode',
      'value': themeMode.index.toString(),
    };
    final ThemeMode? themeModeDb = await getThemeMode();

    // Se existir o themeMode no banco de dados, atualiza, senao insere.
    if (themeModeDb != null) {
      await db
          .update('theme_config', data)
          .where('name', data['name'])
          .execute();
    } else {
      await db.insert('theme_config', data).execute();
    }
  }
}
