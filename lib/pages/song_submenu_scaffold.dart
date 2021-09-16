import "package:flutter/material.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/song_list_page.dart";

class SongSubmenuScaffold extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SongListPage(
        songList: songList,
        showArtist: showArtist,
        showCategories: showCategories,
      ),
    );
  }
}
