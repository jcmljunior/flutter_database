import 'package:flutter/material.dart';

@immutable
class ThemeEntity {
  final String? name;
  final dynamic value;

  const ThemeEntity({
    this.name,
    this.value,
  })  : assert(name != null, 'Name cannot be null'),
        assert(value != null, 'Value cannot be null');
}
