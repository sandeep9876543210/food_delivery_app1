
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{
  static final Dbname='_MyFooddatabase.db';
  static final Dbversion=1;
  static final _tablename='myFoodTable';
  static final columnid='_id';
  static final foodName='name';
  static final foodImage='';
  static final foodValue='';
  static final foodPerValue='';

  DbHelper._privateConstructor();
  static final DbHelper instance= DbHelper._privateConstructor();
  //static late final Database _database;
  static  Database? _database;
  Future<Database?>get database async{
    if(_database!=null) return _database;

    _database=await _initDataBase();
    return _database;
  }
  _initDataBase()async{
    Directory directory=await getApplicationDocumentsDirectory();
    // String path=join(directory.path,Dbname);
    String path=join(directory.path,Dbname);
    return await openDatabase(path,version: Dbversion,onCreate: oncreate);
  }
  Future<void>oncreate(Database db,int version)async{
    return db.execute(
        '''
      CREATE TABLE $_tablename ($columnid INTEGER PRIMARY KEY,
      $foodName TEXT NOT NULL,
      $foodImage TEXT NOT NULL,
      $foodValue TEXT NOT NULL)
      '''
    );
  }

  Future<int?>insert(Map<String,dynamic>row)async{
    Database? db=await instance.database;
    return await db?.insert(_tablename, row);
  }
  Future<List<Map<String,dynamic>>?>quaryall()async{
    Database? db=await instance.database;
    return await db?.query(_tablename);
  }
  Future<int?>update(Map<String,dynamic>row)async{
    Database? db=await instance.database;
    int id=row[columnid];
    return await db?.update(_tablename,row,where: '$columnid=?',whereArgs: [id]);
  }
  Future<int?>delete(int id)async{
    Database? db=await instance.database;
    return await db?.delete(_tablename,where: '$columnid=?',whereArgs: [id]);
  }
}
