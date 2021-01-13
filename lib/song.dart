import "package:sqflite/sqflite.dart";
import "package:ChoproReader/db_utils.dart";
import "package:flutter/material.dart";

class Song {
  int _id;
  String title;
  String artist;

  Song({
    @required this.title,
    @required this.artist,
  });

  Song.fromDatabaseMap(Map<String, dynamic> map) {
    _id = map["id"];
    title = map["title"] ?? "[Title not found]";
    artist = map["artist"] ?? "[Artist not found]";
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
      "id": _id,
      "title": title,
      "artist": artist,
    };
  }

  @override
  String toString() {
    return "Song { title: $title, artist: $artist }";
  }
}

class SongModel {
  static Future<List<Song>> getAllSongs() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query("song_list");
    var list = maps.map((song) => Song.fromDatabaseMap(song)).toList();
    return list;
  }

  static Future<void> insertSong(Song song) async {
    final db = await DBUtils.init();
    var id = await db.insert(
      "song_list",
      song.toDatabaseMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    song._id = id;
  }

  static Future<void> updateSong(Song song) async {
    final db = await DBUtils.init();
    await db.update(
      "song_list",
      song.toDatabaseMap(),
      where: "id = ?",
      whereArgs: [song._id],
    );
  }

  static Future<void> deleteSong(Song song) async {
    final db = await DBUtils.init();
    await db.delete(
      "song_list",
      where: "id = ?",
      whereArgs: [song._id],
    );
  }
}

class SongWidget extends StatelessWidget {
  final Song song;
  final bool showArtist;

  SongWidget({
    this.song,
    this.showArtist = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      subtitle: showArtist ? Text(song.artist) : null,
    );
  }
}
