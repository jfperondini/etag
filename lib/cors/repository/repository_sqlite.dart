// ignore_for_file: avoid_print

import 'package:etag/cors/repository/repository.dart';
import 'package:etag/cors/repository/sqlite_db.dart';
import 'package:sqflite/sqflite.dart';

abstract class RepositorySqlite<Model> extends Repository<Model> {
  Database? _db;

  String get tableName;

  String get idColumnName;

  String? _sqlSelectAll;
  String get sqlSelectAll => _sqlSelectAll ??= "SELECT * FROM $tableName";

  @override
  Future<List<Model>> getAll() async {
    final dbf = _db ??= await Sqlite.instance.db;
    List<Map<String, dynamic>> list = await dbf.rawQuery(sqlSelectAll);
    list.length;
    return convertJsonToModels(list);
  }

  @override
  insert({required Model model}) async {
    final dbf = _db ??= await Sqlite.instance.db;
    Map<String, dynamic> json = convertModelToJson(model);
    String sqlInsert = "INSERT INTO $tableName (${json.keys.join(',')}) VALUES(${json.keys.map((e) => '?').join(',')})";
    return dbf.rawInsert(sqlInsert, json.values.toList());
  }

  @override
  Future<List<Model>> searchLike({required String nameCollum, required String valueCollum}) async {
    final dbf = _db ??= await Sqlite.instance.db;
    String sqlSearchLike = "SELECT * FROM $tableName WHERE $nameCollum LIKE '$valueCollum'";
    List<Map<String, dynamic>> list = await dbf.rawQuery(sqlSearchLike);
    if (list.isEmpty) return [];
    return convertJsonToModels(list);
  }

  String? _sqlDeleteFromId;
  String get sqlDeleteFromId => _sqlDeleteFromId ??= "DELETE FROM $tableName WHERE $idColumnName = ?";

  @override
  delete({required int id}) async {
    final dbf = _db ??= await Sqlite.instance.db;
    return dbf.rawDelete(sqlDeleteFromId, [id]);
  }

  @override
  replaceMany({required List<Map<String, dynamic>> jsons}) async {
    final db = await Sqlite.instance.db;
    await db.transaction(
      (txn) async {
        try {
          for (final json in jsons) {
            String sqlInsert = "REPLACE INTO $tableName (${json.keys.join(',')}) VALUES(${json.keys.map((e) => '?').join(',')})";
            await txn.rawInsert(sqlInsert, json.values.toList());
          }
          await txn.batch().commit(noResult: true);
        } catch (e) {
          await txn.batch().commit(continueOnError: true);
        }
      },
    );
  }

  @override
  deleteMany({required List<Map<String, dynamic>> jsons}) async {
    final db = await Sqlite.instance.db;
    await db.transaction((txn) async {
      try {
        for (final json in jsons) {
          await txn.rawDelete(sqlDeleteFromId, json['id']);
        }
        await txn.batch().commit(noResult: true);
      } catch (e) {
        await txn.batch().commit(continueOnError: true);
      }
    });
  }
}
