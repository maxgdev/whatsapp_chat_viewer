import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:whatsapp_chat_viewer/modules/chats.dart';
// import '../model/chat_model.dart';

class DatabaseHelper {
  static final _databaseName = "WCVDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'wcv_table';

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
    // await db.execute('''
    //       CREATE TABLE $table (
    //         $chatId INTEGER PRIMARY KEY AUTOINCREMENT,
    //         $chatDate TEXT NOT NULL,
    //         $chatTime TEXT NOT NULL,
    //         $chatName TEXT NOT NULL,
    //         $chatMessage TEXT NOT NULL,
    //         )
    //       ''');
    // Database db = await instance.database;
      var sql =
        "CREATE TABLE $table (_id INTEGER PRIMARY KEY AUTOINCREMENT, date  TEXT NOT NULL, time  TEXT NOT NULL, name  TEXT NOT NULL, message  TEXT NOT NULL)";
      await db.execute(sql);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  // Future<int> insert(row) async {
  //   Database db = await instance.database;
  //   return await db.insert(table, row);
  // }

//------------------------------------------------------
  // Batch insert of rows
  // inserting 1 chat per row from List (converstion/file)
  Future batchInsert(tableName, rows) async {
    Database db = await instance.database;

    var batch = db.batch();
    // if table already exists add a number to name or enter new name??
    if (await isTableExits(tableName) == true) {
      print("Table already exists");
      // Warn user and request new name
    } else {
      // Create table in database
      print("Creating table $tableName ...");
      await createTable(tableName);
    }
    // print(table);
    rows.forEach((element) {
      // print(
      //     "${element.date}, ${element.time}, ${element.name}, ${element.message}");
      var row = {
        chatDate: element.date,
        chatTime: element.time,
        chatName: element.name,
        chatMessage: element.message,
      };
      // batch.insert(tableName, row);
      batch.insert(table, row);
    });

    var results = await batch.commit();
    return results;
  }
//------------------------------------------------------

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

  Future<int> update(tableName, row) async {
    Database db = await instance.database;
    int id = row[chatId];
    return await db
        .update(tableName, row, where: '$chatId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$chatId = ?', whereArgs: [id]);
  }

  // Determine whether the table exists
  isTableExits(String tableName) async {
    //Built-in table 'sqlite_master'
    Database db = await instance.database;
    var sql =
        "SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'";
    var res = await db.rawQuery(sql);
    print("tableName: $tableName, res: $res");
    print("res.length: ${res.length}");
    var returnRes = res != null && res.length > 0;
    print("returnRes: $returnRes");
    return returnRes;
  }

  //Create table
  createTable(String tableName) async {
    Database db = await instance.database;
    var sql =
        "CREATE TABLE $tableName (_id INTEGER PRIMARY KEY AUTOINCREMENT, date  TEXT NOT NULL, time  TEXT NOT NULL, name  TEXT NOT NULL, message  TEXT NOT NULL)";

    await db.execute(sql);

  }
}
