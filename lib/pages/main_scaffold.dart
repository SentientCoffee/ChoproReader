import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/artist_list.dart";
import "package:ChoproReader/pages/song_list.dart";

import "package:flutter/material.dart";

class MainScaffold extends StatefulWidget {
  MainScaffold({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _bottomNavbarIndex = 0;

  // @Temporary: implement as database
  List<Song> songList = List<Song>();
  // List<Song> songList = [
  //   Song(title: "Song 1", artist: "Artist 1"),
  //   Song(title: "Song 2", artist: "Artist 2"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  //   Song(title: "Song 3", artist: "Artist 3"),
  // ];

  Future<void> updateSongList() async {
    if (songList.length > 0) songList.clear();
    songList = await SongModel.getAllSongs();
    print("songList: $songList");
  }

  @override
  Widget build(BuildContext context) {
    updateSongList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var returnMsg = await Navigator.pushNamed(context, "/songForm");
              setState(() {
                if (returnMsg != null) print(returnMsg);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              // @Incomplete: Add settings page
              var returnMsg = await Navigator.pushNamed(context, "/settings");
              setState(() {
                if (returnMsg != null) print(returnMsg);
              });
            },
          ),
        ],
      ),
      body: () {
        switch (_bottomNavbarIndex) {
          case 0:
            return SongListPage(songList: songList);
            break;
          case 1:
            return ArtistListPage(songList: songList);
            break;
        }
      }(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 24.0,
        currentIndex: _bottomNavbarIndex,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "Songs",
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            label: "Artists",
            icon: Icon(Icons.mic_external_on),
          ),
        ],
        onTap: (index) {
          setState(() {
            _bottomNavbarIndex = index;
          });
        },
      ),
    );
  }
}
