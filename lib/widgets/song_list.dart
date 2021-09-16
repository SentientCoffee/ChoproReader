import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongList extends StatefulWidget {
  final Widget child;
  final _SongListState _state = _SongListState();

  List<Song> get songList => _state.songs;

  SongList({this.child});

  @override
  _SongListState createState() => _state;

  static SongList of(BuildContext context) => context.findRootAncestorStateOfType<_SongListState>().widget;

  Future<List<Song>> update() async {
    _state.songs = await SongModel.getAllSongs();
    return _state.songs;
  }
}

class _SongListState extends State<SongList> {
  List<Song> songs = [];

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
