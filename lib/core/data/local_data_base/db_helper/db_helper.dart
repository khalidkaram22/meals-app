import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/local_meal_model.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDataBase();
    return _database!;
  }

  Future<Database?> _initDataBase() async {
    String path = join(await getDatabasesPath(), "meals.db");
    return await openDatabase(path, version: 1, onCreate: _createDataBase);
  }

  FutureOr<void> _createDataBase(Database db, int version) async {
    await db.execute('''
CREATE TABLE meals (
  id TEXT PRIMARY KEY,
  name TEXT,
  imageUrl TEXT,
  time TEXT,
  instructions TEXT,
  rate REAL,
  source TEXT
)
''');
  }

  Future<int> insertMeal(LocalMeal meal) async {
    final db = await database;

    final result = await db.insert(
      "meals",
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );


    return result;
  }

  Future<List<LocalMeal>> getMeals() async {
    final db = await database;

    final mealsJson = await db.query("meals");

    return mealsJson.map((e) => LocalMeal.fromMap(e)).toList();
  }


  Future<int> updateMeal(LocalMeal meal) async {
    final db = await database;

    return await db.update(
      "meals",
      meal.toMap(),
      where: "id = ?",
      whereArgs: [meal.id],
    );
  }


  Future<int> deleteMeal(String id) async {
    final db = await database;

    return await db.delete(
      "meals",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
