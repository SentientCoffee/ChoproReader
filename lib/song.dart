import "package:flutter/material.dart";

class Song {
  String title;
  String author;

  Song({this.title, this.author});

  @override
  String toString() {
    return "Song { title: $title, author: $author }";
  }
}

class SongWidget extends StatelessWidget {
  final Song song;

  SongWidget({this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      subtitle: Text(song.author),
    );
  }
}
