import "package:sqflite/sqflite.dart";
import "package:path/path.dart" as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), "song_list.db"),
      onCreate: (db, version) {
        db.execute("CREATE TABLE song_list(id INTEGER PRIMARY KEY, title TEXT, artist TEXT)");
        print("Created song_list database version $version!");
      },
      version: 1,
    );

    return database;
  }
}
