import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart";

import "package:ChoproReader/db_utils.dart";

class Song {
  int _id;
  String title;
  String artist;
  List<String> categories;

  Song({
    @required this.title,
    @required this.artist,
    this.categories = const [],
  });

  Song.fromDatabaseMap(Map<String, dynamic> map) {
    _id = map["id"];
    title = map["title"] ?? "[Title not found]";
    artist = map["artist"] ?? "[Artist not found]";
    categories = ["Test1", "Test2"];
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
    return "Song { title: $title, artist: $artist, categories: $categories }";
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
