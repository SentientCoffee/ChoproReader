import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/artist_song_scaffold.dart";
import "package:flutter/material.dart";

class ArtistListPage extends StatefulWidget {
  final List<Song> songList;

  ArtistListPage({this.songList});

  @override
  _ArtistListPageState createState() => _ArtistListPageState();
}

class _ArtistListPageState extends State<ArtistListPage> {
  @override
  Widget build(BuildContext context) {
    List<String> artistList = [];
    for (var song in widget.songList) {
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
            for (var song in widget.songList) {
              if (song.artist != artistList[index]) continue;
              list.add(song);
            }

            var returnMsg = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArtistSongScaffold(artist: artistList[index], songList: list),
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
