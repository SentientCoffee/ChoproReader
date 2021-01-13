import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongList extends InheritedWidget {
  final List<Song> songs;
  // final List<String> artists;
  // final List<String> categories;

  SongList({@required this.songs, Widget child}) : super(child: child);
  // {
  //   art
  // }

  @override
  bool updateShouldNotify(SongList old) => true;

  static List<Song> of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<SongList>()?.songs ?? [];
}
