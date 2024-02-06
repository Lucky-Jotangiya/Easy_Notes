import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/main.dart';

class Db{

  Future<Database> getDataBase() async {

    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'MyNewDb.db');

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String table1 =
            "create table table1 (id integer primary key,title Text,task Text)";
        db.execute(table1);
      },
    );
    return database;
  }

  Future<void> insertData(String title,String task,Database database) async {
    String insert = "insert into table1 (title,task) values ('$title','$task')";
    int a = await database.rawInsert(insert);
  }

  Future<List<Map>> viewTask(Database database) async {
    String view = "select * from table1";
    List<Map> list = await database.rawQuery(view);
    return list;
  }

  Future<void> remove(int id, Database database) async {
    String remove = "delete from table1 where id = '$id'";
    int b= await database.rawDelete(remove);
  }

  Future<void> update(String title, String task, int id) async {

    Database db = Splash.db;
    String update = "update table1 set title = '$title', task = '$task'";
    int a = await db.rawUpdate(update);

  }
}