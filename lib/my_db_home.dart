import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
// import 'package:flutter_database/database_helper.dart';
import './db_methods.dart';
import './chat_model.dart';


class MyDBHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Insert Chat', style: TextStyle(fontSize: 20),),
              onPressed: () {_insert();},
            ),
            ElevatedButton(
              child: Text('Query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            ElevatedButton(
              child: Text('Update Chat', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            ElevatedButton(
              child: Text('Delete Chat', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }
  
  // Button onPressed methods
  
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnDate : '29/03/2021',
      DatabaseHelper.columnTime : '11:34',
      DatabaseHelper.columnName : 'John',
      DatabaseHelper.columnMessage : 'This is a test message for the chat',
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnDate : '29/03/2021',
      DatabaseHelper.columnTime : '12:34',
      DatabaseHelper.columnName : 'John',
      DatabaseHelper.columnMessage : 'This test MESSAGE has changed',
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}