class ThemeSchema {
  static const String name = 'name';
  static const String value = "value";
  static const String tableName = "theme_config";
  static const List<String> columns = [name, value];
  static const Map<String, String> values = {
    name: "TEXT PRIMARY KEY UNIQUE NOT NULL",
    value: "TEXT NOT NULL"
  };
  static final createTable =
      '''CREATE TABLE IF NOT EXISTS $tableName (${values.entries.map((e) => '${e.key} ${e.value}').join(', ')})''';
}
