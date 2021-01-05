import "package:ChoproReader/pages/song_list.dart";
import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class ArtistSongScaffold extends StatefulWidget {
  final String artist;
  final List<Song> songList;

  ArtistSongScaffold({this.artist, this.songList});

  @override
  _ArtistSongScaffoldState createState() => _ArtistSongScaffoldState();
}

class _ArtistSongScaffoldState extends State<ArtistSongScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artist),
      ),
      body: SongListPage(songList: widget.songList, showArtist: false),
    );
  }
}
