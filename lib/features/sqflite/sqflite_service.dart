import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../core/theme/theme_schema.dart';

class SqfliteService {
  String _query = '';
  final List<dynamic> _params = [];

  // Singleton
  static final SqfliteService instance = SqfliteService._();
  static Database? _database;

  SqfliteService._();

  factory SqfliteService() => instance;

  Future<Database> get database async {
    _database ??= await initDatabase();

    return _database!;
  }

  Future<Database> initDatabase({String? dbName}) async {
    final appDocumentsDir = await getApplicationCacheDirectory();
    final String dbPath =
        p.join(appDocumentsDir.path, "data", "${dbName ?? "database"}.db");

    // await deleteDatabase(dbPath);

    return await databaseFactory.openDatabase(
      dbPath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(ThemeSchema.createTable);
        },
      ),
    );
  }

  Future<void> closeDatabase() async {
    await _database?.close();
    _database = null;
  }

  SqfliteService select([List<String>? columns]) {
    final cols = columns?.join(', ') ?? '*';
    _query = 'SELECT $cols';
    _params.clear();

    return this;
  }

  SqfliteService insert(String table, Map<String, dynamic> values) {
    final cols = values.keys.join(', ');
    final placeholders = values.keys.map((_) => '?').join(', ');
    _query = 'INSERT INTO $table ($cols) VALUES ($placeholders)';
    _params.clear();
    _params.addAll(values.values);

    return this;
  }

  SqfliteService update(String table, Map<String, dynamic> values) {
    final setClause = values.keys.map((key) => '$key = ?').join(', ');
    _query = 'UPDATE $table SET $setClause';
    _params.clear();
    _params.addAll(values.values);

    return this;
  }

  SqfliteService delete(String table) {
    _query = 'DELETE FROM $table';
    _params.clear();

    return this;
  }

  SqfliteService from(String table) {
    _query += ' FROM $table';

    return this;
  }

  SqfliteService where(String column, dynamic value, [String operator = '=']) {
    _query += _query.contains('WHERE')
        ? ' AND $column $operator ?'
        : ' WHERE $column $operator ?';
    _params.add(value);

    return this;
  }

  SqfliteService orderBy(String column, [bool ascending = true]) {
    _query += ' ORDER BY $column ${ascending ? 'ASC' : 'DESC'}';

    return this;
  }

  SqfliteService groupBy(String column) {
    _query += ' GROUP BY $column';

    return this;
  }

  SqfliteService limit(int limit) {
    _query += ' LIMIT $limit';

    return this;
  }

  SqfliteService offset(int offset) {
    _query += ' OFFSET $offset';

    return this;
  }

  SqfliteService join(String table, String onCondition,
      [String joinType = 'INNER']) {
    _query += ' $joinType JOIN $table ON $onCondition';

    return this;
  }

  SqfliteService createTable(String tableName, Map<String, String> columns) {
    final columnDefinitions =
        columns.entries.map((e) => '${e.key} ${e.value}').join(', ');
    _query = 'CREATE TABLE IF NOT EXISTS $tableName ($columnDefinitions)';

    return this;
  }

  SqfliteService drop(String table) {
    _query = 'DROP TABLE IF EXISTS $table';

    return this;
  }

  SqfliteService likeAndWhere(String column, dynamic value) {
    if (_query.contains('WHERE')) {
      _query += ' AND $column LIKE ?';
    } else {
      _query += ' WHERE $column LIKE ?';
    }
    _params.add("%$value%");

    return this;
  }

  SqfliteService likeOrWhere(String column, dynamic value) {
    if (_query.contains('WHERE')) {
      _query += ' OR $column LIKE ?';
    } else {
      _query += ' WHERE $column LIKE ?';
    }
    _params.add("%$value%");

    return this;
  }

  Future<dynamic> execute() async {
    if (_query.isEmpty) {
      return;
    }

    // Importante para não executar várias vezes o mesmo query
    final queryToExecute = _query;
    final paramsToExecute = List<dynamic>.from(_params);

    // Limpa para não executar várias vezes o mesmo query
    _query = '';
    _params.clear();

    return await database
        .then((Database db) => db.rawQuery(queryToExecute, paramsToExecute));
  }
}
