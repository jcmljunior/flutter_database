import 'package:flutter/widgets.dart';
import 'localization_store.dart';

@immutable
class LocalizationManager extends InheritedWidget {
  final LocalizationStore store;

  const LocalizationManager({
    super.key,
    required super.child,
    required this.store,
  });

  @override
  bool updateShouldNotify(covariant LocalizationManager oldWidget) {
    return store != oldWidget.store;
  }

  static LocalizationManager of(BuildContext context) {
    final LocalizationManager? result =
        context.dependOnInheritedWidgetOfExactType<LocalizationManager>();

    assert(result != null, 'No LocalizationManager found in context');
    return result!;
  }
}
