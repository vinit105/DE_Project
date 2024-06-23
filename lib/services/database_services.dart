
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/tasks.dart';

class DatabaseServices {
  static Database? _db;
  static final DatabaseServices instance = DatabaseServices._constructor();

  final String _taskTableName = "tasks";
  final String _taskIdColumnName = "id";
  final String _taskContentColumnName = "content";
  final String _taskTitleColumnName = "title";
  final String _taskIsCompletedColumnName = "isCompleted";
  final String _taskTimeColumName = "time";
  final String _taskDateColumnName = "date";
  final String _taskRepeatColumnName = "repeat";
  final String _taskCategoryColumnName = "category";

  DatabaseServices._constructor();
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_taskTableName(
        $_taskIdColumnName STRING PRIMARY KEY ,
        $_taskTitleColumnName STRING NOT NULL,
        $_taskContentColumnName STRING NOT NULL,
        $_taskDateColumnName STRING NOT NULL,
        $_taskTimeColumName STRING NOT NULL,
        $_taskRepeatColumnName STRING NOT NULL,
        $_taskCategoryColumnName STRING NOT NULL,
        $_taskIsCompletedColumnName INTEGER NOT NULL
        
            )
       ''');
      },
    );
    return database;
  }

  void addTask(
      String id,
    String title,
    String content,
    String date,
    String time,
    String repeat,
    String category,
  ) async {
    final db = await database;
    await db.insert(
      _taskTableName,
      {
        _taskIdColumnName:id,
        _taskTitleColumnName: title,
        _taskContentColumnName: content,
        _taskDateColumnName: date,
        _taskTimeColumName: time,
        _taskRepeatColumnName: repeat,
        _taskCategoryColumnName: category,
        _taskIsCompletedColumnName: 0,
      },
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_taskTableName);
    List<Task> task = data
        .map((e) => Task(
        id: e["id"] as String,
        title: e["title"] as String,
      content: e["content"] as String,
        date: e["date"] as String,
        time: e["time"] as String,
        repeat: e["repeat"] as String,
        category: e["category"] as String,
        isCompleted: e["isCompleted"] as int,
        ))
        .toList();
    return task;
  }

  Future<List<Task>> getTasksByCategory(String category) async {
    final db = await database;
    final data = await db.query(_taskTableName,where: 'category=?',whereArgs: [category], orderBy: _taskIsCompletedColumnName);
    List<Task> task = data
        .map((e) => Task(
      id: e["id"] as String,
      title: e["title"] as String,
      content: e["content"] as String,
      date: e["date"] as String,
      time: e["time"] as String,
      repeat: e["repeat"] as String,
      category: e["category"] as String,
      isCompleted: e["isCompleted"] as int,
    ))
        .toList();
    return task;
  }

  void updateComplete(String id, int isComplete) async{
    final db = await database;
    await db.update(_taskTableName, {
      _taskIsCompletedColumnName: isComplete,
    },
      where: 'id = ?',
      whereArgs: [
        id,
      ]
    );

  }
  void deleteTask(String id) async {
    final db = await database;
    await db.delete(
      _taskTableName,
      where: 'id = ?',
      whereArgs: [id,],
    );
  }
}
