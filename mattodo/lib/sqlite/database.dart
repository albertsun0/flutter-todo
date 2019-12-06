// import 'dart:async';
// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'event.dart';
// import 'package:sqflite/sqflite.dart';

// class DBProvider {
//   DBProvider._();

//   static final DBProvider db = DBProvider._();

//   Database _database;

//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "TestDB.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE Items ("
//           "id INTEGER PRIMARY KEY,"
//           "text TEXT,"
//           "repeat BIT,"
//           "longterm BIT"
//           ")");
//     });
//   }

//   newTask(Task newTask) async {
//     final db = await database;
//     //get the biggest id in the table
//     var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Task");
//     int id = table.first["id"];
//     //insert to the table using the new id
//     var raw = await db.rawInsert(
//         "INSERT Into Task (id,text,repeat,longterm)"
//         " VALUES (?,?,?,?)",
//         [id, newTask.text,  newTask.repeat, newTask.longterm]);
//     return raw;
//   }

//   updateClient(Task newt) async {
//     final db = await database;
//     var res = await db.update("Task", newt.toMap(),
//         where: "id = ?", whereArgs: [newt.id]);
//     return res;
//   }

//   getClient(int id) async {
//     final db = await database;
//     var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Task.fromMap(res.first) : null;
//   }

//   Future<List<Client>> getAllClients() async {
//     final db = await database;
//     var res = await db.query("Client");
//     List<Client> list =
//         res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
//     return list;
//   }

//   deleteClient(int id) async {
//     final db = await database;
//     return db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }
// }