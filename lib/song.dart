import "package:ChoproReader/db_utils.dart";
import "package:flutter/material.dart";

class Song {
  String title;
  String artist;

  Song({
    @required this.title,
    @required this.artist,
  });

  Song.fromDatabaseMap(Map<String, dynamic> map) {
    title = map["title"] ?? "";
    artist = map["artist"] ?? "";
  }

  Map<String, dynamic> toDatabaseMap() {
    return {
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
    return maps.map((song) => Song.fromDatabaseMap(song)).toList(growable: false);
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
