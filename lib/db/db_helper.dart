 import 'package:gestion_tache/models/task.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database?  _db;
  static final int _version = 1;
  static final String   _tableName = 'tasks';

  static Future<void> initDb() async{
    if(_db != null){
          return;
    }
    try{
        String _path = await  getDatabasesPath() + 'tasks.db';
        _db = await openDatabase(
            _path,
          version: _version,
          onCreate: (db,_version) async{
              print("Creer un nouveau ");
             await  db.execute(
                "CREATE TABLE $_tableName ("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "titre TEXT ,note TEXT,date TEXT, "
                    "debutHeure TEXT ,finHeure TEXT, "
                    "rappel INTEGER , repetition TEXT, "
                    "couleur INTEGER,"
                    "isCompleted INTEGER)",


              );
          }
        );
        print("Database : $_db");
    }catch(e){
      print(e);
    }
  }
    static Future<int> insert(Task? task)  async{
      print("la fonction insert est applee");
      return await _db?.insert(_tableName, task!.toJson())??1;
    }

    static Future<List<Map<String,dynamic>>> query() async {
      print("la fonction query est appelee");
      return await _db!.query(_tableName);
    }

    static delete(Task task) async {
    return  await  _db!.delete(_tableName, where: 'id=?' ,whereArgs: [task.id]);

    }

    static update(int id) async{
    return await _db!.rawUpdate('''
    UPDATE tasks
    SET isCompleted = ?
    WHERE id = ?
    ''',[1, id]);
    }
 }