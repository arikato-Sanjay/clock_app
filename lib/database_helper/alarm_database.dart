import 'package:clock_app/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'alarm';
final String alarmId = 'id';
final String alarmTitle = 'description';
final String alarmDataTime = 'alarmDateTime';
final String alarmActive = 'isActive';
final String alarmColorIndex = 'gradientIndex';

class AlarmDatabase {
  static Database _database;
  static AlarmDatabase _alarmDatabase;

  //singleton for alarm database
  AlarmDatabase._createInstance();
  factory AlarmDatabase(){
    if(_alarmDatabase == null)
      _alarmDatabase = AlarmDatabase._createInstance();
    return _alarmDatabase;
  }

  //singleton implementation
  Future<Database> get database async {
    if (_database == null) _database = await initializeDatabase();
    return _database;
  }

  //initializing database
  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + 'alarm.db';

    //opening database
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
          db.execute('''
            create table $tableName (
            $alarmId integer primary key autoincrement,
            $alarmTitle text not null,
            $alarmDataTime text not null,
            $alarmActive integer,
            $alarmColorIndex integer
            )
          ''');
        });

    return database;
  }

  //performing crud's
  // 1. insert method
  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await this.database;
    var result = await db.insert(tableName, alarmInfo.toMap());
    print('result + $result');
  }

  //fetch operation
  Future<List<AlarmInfo>> getAlarms() async{
    List<AlarmInfo> _alarms = [];
    var db = await this.database;
    var result = await db.query(tableName);
    result.forEach((element) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableName, where: '$alarmId = ?', whereArgs: [id]);
  }
}
