// ignore_for_file: depend_on_referenced_packages, avoid_print
import 'dart:io';
import 'package:etag/domain/model/generator_model.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class Sqlite {
  Sqlite._();
  static Sqlite? _instance;

  static Sqlite get instance => _instance ??= Sqlite._();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    final openDB = await open();
    return openDB;
  }

  Future<Database> open() async {
    String databasesPath = await getDatabasesPath();
    String pathJoin = path.join(databasesPath, 'etag.db');
    bool fileExists = await File(pathJoin).exists();
    if (!fileExists) {
      await File(pathJoin).create(recursive: true);
    }
    _db ??= await openDatabase(pathJoin);
    return _db!;
  }

  Future<bool> onReplace({required QueryGeneratorModel queryGeneratorModel}) async {
    for (final sql in queryGeneratorModel.listSql) {
      await _db?.transaction((txn) {
        txn.execute(sql);
        return txn.batch().commit(noResult: true);
      });
    }
    return false;
  }

  onTableName() async {
    await _db?.transaction((txn) async {
      final List<Map<String, dynamic>> tables = await txn.rawQuery(
        'SELECT name FROM sqlite_master WHERE type=?',
        ['table'],
      );
      for (final table in tables) {
        final tableName = table['name'] ?? '';
        final List<Map<String, dynamic>> tableInfo = await txn.rawQuery(
          'PRAGMA table_info($tableName)',
        );
        for (final column in tableInfo) {
          final columnName = column['name'] ?? '';
          print('$tableName:- $columnName');
        }
      }
    }, exclusive: true);
  }
}
