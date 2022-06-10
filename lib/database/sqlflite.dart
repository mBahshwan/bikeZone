import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'bikeZone.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 2, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) async {
    await db.execute("ALTER TABLE clients ADD COLUMN signature TEXT");
    print("onUpgrade =====================================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "clients" (
    "id" INTEGER  NOT NULL , 
    "time" TEXT,
    "duration" TEXT,
    "kidzCycles" INTEGER,
    "adultCycles" INTEGER,
    "name" TEXT NOT NULL,
    "phone" INTEGER NOT NULL

  )
 ''');
    await db.execute('''
  CREATE TABLE "currentClients" (
    "id" INTEGER  NOT NULL , 
    "time" INTEGER ,
    "duration" TEXT,
    "kidzCycles" INTEGER,
    "adultCycles" INTEGER,
    "name" TEXT NOT NULL,
    "phone" INTEGER NOT NULL

  )
 ''');
    print(" onCreate =====================================");
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  Future getCount(String sql) async {
    Database? mydb = await db;

    final response = (await mydb!
        .rawQuery("SELECT COUNT(*) FROM clients WHERE  id = ${sql}"));
    int? count = Sqflite.firstIntValue(response);

    return count;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}

removeDataBase() async {
  String databasepath = await getDatabasesPath();
  String path = join(databasepath, 'bikeZone.db');
  await deleteDatabase(path);
  print("REMOVED =======================");
}
