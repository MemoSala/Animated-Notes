import 'dart:async';
import 'dart:io';

import 'package:get/get_utils/src/platform/platform.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'sql_tools.dart';

SQLTABLE notesTABLE = const SQLTABLE('notes', [
  SQLVar(
    "id",
    type: SQLConstantType.integer,
    isPrimaryKey: true,
    isAutoincrement: true,
  ),
  SQLVar("data", type: SQLConstantType.text),
  SQLVar("type", type: SQLConstantType.text),
  SQLVar("offset_x", type: SQLConstantType.float),
  SQLVar("offset_y", type: SQLConstantType.float),
  SQLVar("width", type: SQLConstantType.float),
  SQLVar("height", type: SQLConstantType.float),
]);

class SqlDB {
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _intialDb();
    return _database;
  }

  Future<Database> _intialDb() async {
    String databasePath = GetPlatform.isAndroid
        ? (await getApplicationDocumentsDirectory()).path
        : await getDatabasesPath();
    if (!await Directory(databasePath).exists()) {
      await Directory(databasePath).create(recursive: true);
    }
    String path = join(databasePath, 'sql_test_web.db');
    Database mydb = await openDatabase(
      path,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
      version: 1,
    );
    /*await insertData(
      from: notesTABLE,
      intoValues: {
        "data": "assets/images/photo.jpeg",
        "type": "imageAsset",
        "offset_x": "100",
        "offset_y": "80",
        "width": "480",
        "height": "500",
      },
    );
    await insertData(
      from: notesTABLE,
      intoValues: {
        "data":
            "Welcome to our application.\nWe're excited to have you join us.",
        "type": "note",
        "offset_x": "600",
        "offset_y": "180",
        "width": "200",
        "height": "100",
      },
    );*/
    return mydb;
  }

  FutureOr<void> _createDB(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute(notesTABLE.createTable());
    await batch.commit();
  }

  FutureOr<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 1) {}
    if (oldVersion < 2) {}
    if (oldVersion < 3) {}
    if (oldVersion < 4) {}
    if (oldVersion < 5) {}
  }

  //--SQL-------------------------------------------------------------------------

  //SELECT * FOR animes
  Future<List<Map<String, Object?>>> readData({
    String select = "*",
    required SQLTABLE from,
    String? where,
  }) async {
    Database? mydb = await database;
    List<Map<String, Object?>> listMap = await mydb!.rawQuery(
      'SELECT $select FROM ${from.nameTable} ${where == null ? "" : "WHERE $where"} ;',
    );
    return listMap;
  }

  //INSERT INTO animes(...) VALUES(...)
  Future<int> insertData({
    required SQLTABLE from,
    required Map<String, Object?> intoValues,
  }) async {
    Database? mydb = await database;
    int listMap = await mydb!.insert(from.nameTable, intoValues);
    return listMap;
  }

  //update animes WHERE ...;",
  Future<int> updateData({
    required SQLTABLE from,
    required Map<String, Object?> setValues,
    String? where,
  }) async {
    Database? mydb = await database;
    int listMap = await mydb!.update(from.nameTable, setValues, where: where);
    return listMap;
  }

  //DElETE FROM animes WHERE ...;",
  Future<int> deleteData({required SQLTABLE from, String? where}) async {
    Database? mydb = await database;
    int listMap = await mydb!.delete(from.nameTable, where: where);
    return listMap;
  }

  //--DB--------------------------------------------------------------------------
  deleteDB() async {
    String databasePath = await getDatabasesPath(); // Path Folder DB
    String path = join(databasePath, 'sql.db'); // Create Path DB
    await deleteDatabase(path);
  }
}

Future<void> initialSql() async {
  await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  if (GetPlatform.isWindows || GetPlatform.isLinux) sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}
