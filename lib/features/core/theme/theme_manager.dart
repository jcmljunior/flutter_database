import 'package:flutter/material.dart';
import 'theme_store.dart';

@immutable
class ThemeManager extends InheritedWidget {
  final ThemeStore store;

  const ThemeManager({
    super.key,
    required super.child,
    required this.store,
  });

  @override
  bool updateShouldNotify(covariant ThemeManager oldWidget) {
    return store != oldWidget.store;
  }

  static ThemeManager of(BuildContext context) {
    final ThemeManager? result =
        context.dependOnInheritedWidgetOfExactType<ThemeManager>();

    assert(result != null, 'No ThemeManager found in context');
    return result!;
  }
}
