import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongList extends InheritedWidget {
  final List<Song> songs;

  SongList({@required this.songs, Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(SongList old) => true;

  static List<Song> of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<SongList>()?.songs ?? [];
}
