import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:recite_words/db_recite/recite_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBRecite extends GetxService {
  late Database dbBase;

  Future<DBRecite> init() async {
    await createReciteDB();
    return this;
  }

  createReciteDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'recite.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createReciteTable(db);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isFirst', true);
      await prefs.setBool('isSecond', false);
    });
  }

  createReciteTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS recite (id INTEGER PRIMARY KEY, createdTime TEXT)');
  }

  insertRecite(ReciteEntity entity) async {
    final id = await dbBase.insert('recite', {
      'createdTime': entity.createdTime.toIso8601String(),
    });
    return id;
  }

  Future<List<ReciteEntity>> getReciteAllData() async {
    var result = await dbBase.query('recite', orderBy: 'createdTime DESC');
    return result.map((e) => ReciteEntity.fromJson(e)).toList();
  }
}
