import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongList extends InheritedWidget {
  final List<Song> songs; //_SongList();

  // List<Song> get songList => _songs.list;

  SongList({@required this.songs, Widget child}) : super(child: child);

  // Future<List<Song>> updateSongList() async {
  //   var list = await SongModel.getAllSongs();
  //   _songs.list.clear();
  //   _songs.list = list;
  //   print("songList: $list");
  //   return list;
  // }

  @override
  bool updateShouldNotify(SongList old) => true;

  static List<Song> of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<SongList>()?.songs ?? [];
}

// class _SongList {
//   List<Song> list = [];
// }
