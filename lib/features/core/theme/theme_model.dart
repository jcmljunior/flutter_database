import 'theme_entity.dart';

class ThemeModel extends ThemeEntity {
  const ThemeModel({
    super.name,
    super.value,
  });

  ThemeModel copyWith({
    String? name,
    String? value,
  }) =>
      ThemeModel(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'value': value,
      };

  factory ThemeModel.fromMap(Map<String, dynamic> map) => ThemeModel(
        name: map['name'],
        value: map['value'],
      );

  bool isEqualTo(ThemeModel other) =>
      name == other.name && value == other.value;
}
