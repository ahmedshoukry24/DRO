import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import 'model.dart';

class DatabaseHelper{

  static Database _db;
  static String tableName = 'patient';
  static String cId = 'id';
  static String cEmail  = 'email';
  static String cStatus = 'status';
  static String cFName = 'first_name';
  static String cLName = 'last_name';

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await initDB();
      return _db;
    }
  }

  initDB() async{
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path,'my.db');

    var ourDB = await openDatabase(path,version: 1,onCreate: _onCreate);
    return ourDB;
  }




  void _onCreate(Database db, int version) async {

    await db.execute("CREATE TABLE $tableName($cId INTEGER PRIMARY KEY, "
        "$cEmail TEXT,$cFName TEXT, $cLName TEXT,  $cStatus INTEGER);");

    /*
    id | email | status
    -------------------------
    '2'|'EMAIL'| '0'
     */
  }

  Future<int> saveUser(OfflineUser user) async{
    var dbClient = await db;
    int res = await dbClient.insert('$tableName', user.toMap());
    return res;
  }

  Future<OfflineUser> getUser() async{
    var dbClient = await db;

    OfflineUser user = OfflineUser(status: '0');

    var res = await dbClient.rawQuery("SELECT * FROM $tableName");

    if(res.length == 0){
      return user;
    }else{
      return OfflineUser.fromMap(res.first);
    }
  }

  Future<int> deleteUser(String status) async{
    var dbClient = await db;
    return await dbClient.delete(tableName,where: '$cStatus = ? ' , whereArgs: [status]);
  }

  Future<List> getAllUsers()async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName");
    return res.toList();
  }

  Future updateName(OfflineUser user)async{
    var dbClient = await db;
    return await dbClient.update(tableName, user.toMap(),where: '$cId = ?',whereArgs: [user.id]);
  }

}