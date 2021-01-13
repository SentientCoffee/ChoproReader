import "package:sqflite/sqflite.dart";
import "package:path/path.dart" as path;

class DBUtils {
  static Future<Database> init() async {
    var dbPath = path.join(await getDatabasesPath(), "song_list.db");
    var shouldRecreate = false;

    var _version = 4;
    Function(Database, int) _onCreate = (db, version) async {
      db.execute("CREATE TABLE song_list(id INTEGER PRIMARY KEY, title TEXT, artist TEXT, categories TEXT)");
      print("Created song_list database version $version!");
    };

    var database = await openDatabase(
      dbPath,
      version: _version,
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < _version) shouldRecreate = true;
      },
    );

    if (shouldRecreate) {
      print("[DBUtils:init] Recreating database!");
      await database.close();
      await deleteDatabase(dbPath);
      database = await openDatabase(dbPath, version: _version, onCreate: _onCreate);
    }

    return database;
  }
}
