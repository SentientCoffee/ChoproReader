import "package:flutter/material.dart";
import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/song_submenu_scaffold.dart";
import "package:ChoproReader/widgets/song_list.dart";

class ArtistListPage extends StatefulWidget {
  ArtistListPage();

  @override
  _ArtistListPageState createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  @override
  Widget build(BuildContext context) {
    List<Song> songList = SongList.of(context).songList;
    List<String> artistList = [];

    for (var song in songList) {
      if (artistList.contains(song.artist)) continue;
      artistList.add(song.artist);
    }

    return ListView.separated(
      itemCount: artistList.length + 1,
      itemBuilder: (context, index) {
        if (index == artistList.length) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "${artistList.length} artists",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () async {
            List<Song> list = [];
            for (var song in songList) {
              if (song.artist != artistList[index]) continue;
              list.add(song);
            }

            var returnMsg = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongSubmenuScaffold(
                  title: "Artist: ${artistList[index]}",
                  songList: list,
                  showArtist: false,
                ),
              ),
            );
            if (returnMsg != null) print(returnMsg);
          },
          child: ListTile(title: Text(artistList[index])),
        );
      },
      separatorBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Divider(
          thickness: 1,
          color: Colors.grey[700],
          height: 2,
        ),
      ),
    );
  }
}
