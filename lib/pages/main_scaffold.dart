import "package:flutter/material.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/utils.dart";

import "package:ChoproReader/pages/artist_list.dart";
import "package:ChoproReader/pages/category_list.dart";
import "package:ChoproReader/pages/song_list.dart";

import "package:ChoproReader/widgets/inherited_song_list.dart";

class MainScaffold extends StatefulWidget {
  final GlobalKey key = GlobalKey();
  final String title;

  MainScaffold({this.title});

  @override
  _MainScaffoldState createState() => _MainScaffoldState();

  static MainScaffold of(BuildContext context) => context.findAncestorWidgetOfExactType<MainScaffold>();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _bottomNavbarIndex = 0;
  List<Song> songList = [];

  Future<List<Song>> updateSongList() async {
    var list = await SongModel.getAllSongs();
    songList.clear();
    songList = list;
    return list;
  }

  @override
  void initState() {
    super.initState();
    updateSongList();
  }

  @override
  Widget build(BuildContext context) {
    return SongList(
      songs: songList,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                var returnMsg = await Navigator.pushNamed(context, "/songForm", arguments: null);
                setState(() {
                  if (returnMsg != null) print(returnMsg);
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                var returnMsg = await Navigator.pushNamed(context, "/settings");
                setState(() {
                  if (returnMsg != null) print(returnMsg);
                });
              },
            ),
          ],
        ),
        body: StreamBuilder(
          stream: updateSongList().asStream(),
          initialData: <Song>[],
          builder: (context, AsyncSnapshot<List<Song>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            print("snapshot data: ${snapshot.data}");

            switch (_bottomNavbarIndex) {
              case 0:
                return SongListPage(songList: snapshot.data);
              case 1:
                return ArtistListPage(songList: snapshot.data);
              case 2:
                return CategoryListPage(songList: snapshot.data);
            }

            return Utils.buildErrorPage(widget.toString(), "build", "This tab is not supported yet!");
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 24.0,
          currentIndex: _bottomNavbarIndex,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          items: [
            BottomNavigationBarItem(
              label: "Songs",
              icon: Icon(Icons.music_note),
            ),
            BottomNavigationBarItem(
              label: "Artists",
              icon: Icon(Icons.mic_external_on),
            ),
            BottomNavigationBarItem(
              label: "Categories",
              icon: Icon(Icons.view_list_rounded),
            ),
          ],
          onTap: (index) {
            setState(() {
              _bottomNavbarIndex = index;
            });
          },
        ),
      ),
    );
  }
}
