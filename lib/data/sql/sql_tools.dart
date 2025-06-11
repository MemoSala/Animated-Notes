enum SQLConstantType { integer, text, float }

Map<SQLConstantType, String> sqlType = {
  SQLConstantType.integer: 'INTEGER',
  SQLConstantType.text: 'TEXT',
  SQLConstantType.float: 'REAL',
};

class SQLVar {
  final String key;
  final SQLConstantType type;
  final bool isNull;
  final bool isPrimaryKey;
  final bool isAutoincrement;

  const SQLVar(
    this.key, {
    required this.type,
    this.isNull = false,
    this.isPrimaryKey = false,
    this.isAutoincrement = false,
  });

  @override
  String toString() =>
      "'$key' ${sqlType[type]} ${isNull ? 'NULL' : 'NOT NULL'} ${isPrimaryKey ? 'PRIMARY KEY' : ''} ${isAutoincrement ? 'AUTOINCREMENT' : ''}";
}

class SQLTABLE {
  final String nameTable;
  final List<SQLVar> _vars;

  const SQLTABLE(this.nameTable, this._vars);

  String createTable() => "CREATE TABLE '$nameTable' (${_vars.join(",")});";

  String addColumn(SQLVar column) =>
      "ALTER TABLE '$nameTable' ADD COLUMN $column;";

  Map<String, SQLVar> get vars => {
    for (SQLVar sqlVar in _vars) sqlVar.key: sqlVar,
  };
}
