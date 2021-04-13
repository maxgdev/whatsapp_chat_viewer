import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whatsapp_chat_viewer/modules/chats.dart';
import '../model/chat_model.dart';

class DatabaseHelper {
  // static final _databaseName = "MyDatabase.db";
  static final _databaseName = "WCVDatabase.db";
  static final _databaseVersion = 1;

  // static final table = 'my_table';
  static final table = 'wcv_table';

  // static final columnId = '_id';
  // static final columnName = 'name';
  // static final columnList = 'list';

  static final chatId = '_id';
  static final chatDate = 'date';
  static final chatTime = 'time';
  static final chatName = 'name';
  static final chatMessage = 'message';
  static final chatFileAttached = 'fileAttached';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $chatId INTEGER PRIMARY KEY AUTOINCREMENT,
            $chatDate TEXT NOT NULL,
            $chatTime TEXT NOT NULL,
            $chatName TEXT NOT NULL,
            $chatMessage TEXT NOT NULL,
            )
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }



//------------------------------------------------------
  // Batch indert of rows
  // inserting 1 chat per row from List (converstion/file)
  Future batchInsert(rows) async {
    Database db = await instance.database;

    var batch = db.batch();
    // Create table in database

    // batch.execute('''
    //       CREATE TABLE $table (
    //         $chatId INTEGER PRIMARY KEY AUTOINCREMENT,
    //         $chatDate TEXT NOT NULL,
    //         $chatTime TEXT NOT NULL,
    //         $chatName TEXT NOT NULL,
    //         $chatMessage TEXT NOT NULL,
    //         )
    //       ''');

    // Batch batch = db.batch();
    // for (Map<String, Object> row in rows) {
    //   batch.insert(table, row);
    //   // batch.insert('Test', {'name': 'item6'});
    // }
    rows.forEach((element) {
      print(
          "${element.date}, ${element.time}, ${element.name}, ${element.message}");
      var row = {
        chatDate: element.date,
        chatTime: element.time,
        chatName: element.name,
        chatMessage: element.message,
      };
      batch.insert(table, row);
    });

    var results = await batch.commit();
    return results;
  }
//------------------------------------------------------

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(row) async {
    Database db = await instance.database;
    int id = row[chatId];
    return await db.update(table, row, where: '$chatId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$chatId = ?', whereArgs: [id]);
  }
}
