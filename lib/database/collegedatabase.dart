// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CollegeDataBase extends GetxController {
  static final CollegeDataBase instance = CollegeDataBase();
  static Database? _database;
  CollegeDataBase();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory applicationDirectory = await getApplicationDocumentsDirectory();
    // ignore: avoid_print
    print("The database is here" + applicationDirectory.path);
    final String path = join(await getDatabasesPath(), 'CollegeData.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _CreateTable,
    );
  }

  Future<void> _CreateTable(Database db, int version) async {
    return await db.execute('''
CREATE TABLE CollegeTable (
  id INTEGER PRIMARY KEY,
  name TEXT,
  reg TEXT,
  Department TEXT,
  College TEXT

)''');
  }

  Future<int> InsertData(Map<String, dynamic> data) async {
    Database db = await instance.database;
    return await db.insert('CollegeTable', data);
  }

  Future<List<Map<String, dynamic>>> GetAllData() async {
    Database db = await instance.database;
    return await db.query('CollegeTable');
  }

  Future<int> updateData(int id, Map<String, dynamic> data) async {
    Database db = await instance.database;
    int id = data['id'];
    return await db.update(
      'CollegeTable',
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'CollegeTable',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
