import "package:ChoproReader/pages/song_list.dart";
import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongSubmenuScaffold extends StatefulWidget {
  final String title;
  final List<Song> songList;
  final bool showArtist;
  final bool showCategories;

  SongSubmenuScaffold({
    this.title,
    this.songList,
    this.showArtist = true,
    this.showCategories = true,
  });

  @override
  _SongSubmenuScaffoldState createState() => _SongSubmenuScaffoldState();
}

class _SongSubmenuScaffoldState extends State<SongSubmenuScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SongListPage(
        songList: widget.songList,
        showArtist: widget.showArtist,
        showCategories: widget.showCategories,
      ),
    );
  }
}
