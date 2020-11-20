import "package:ChoproReader/song.dart";

import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";

class SongSelectPage extends StatefulWidget {
  SongSelectPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SongSelectPageState createState() => _SongSelectPageState();
}

class _SongSelectPageState extends State<SongSelectPage> {
  Offset _tapPosition;

  Future<bool> _showDeleteDialog(BuildContext context, Song song) async {
    var ret = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Delete?"),
        content: Text("Are you sure you want to delete \"${song.title}\"? "),
        elevation: 24.0,
        actions: [
          FlatButton(
            child: Text("Yes"),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          FlatButton(
            child: Text("No"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    );

    return ret ?? false;
  }

  Future<void> _tryDeleteSongFromList(BuildContext context, Song song) async {
    if (await _showDeleteDialog(context, song)) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Deleted \"${song.title}\" from song list"),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        songList.remove(song);
      });
    }
  }

  List<Song> songList = [
    Song(title: "Song 1", author: "Author 1"),
    Song(title: "Song 2", author: "Author 2"),
    Song(title: "Song 3", author: "Author 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                var returnMsg = await Navigator.pushNamed(context, "/songForm");
                setState(() {
                  if (returnMsg != null) print(returnMsg);
                });
              },
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: songList.length + 1,
        itemBuilder: (context, index) {
          if (index == songList.length) {
            return Center(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "${songList.length} songs",
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            );
          }

          return GestureDetector(
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: SongWidget(song: songList[index]),
              secondaryActions: [
                IconSlideAction(
                  icon: Icons.delete,
                  color: Colors.red,
                  onTap: () => _tryDeleteSongFromList(context, songList[index]),
                ),
              ],
            ),
            onTapDown: (details) {
              _tapPosition = details.globalPosition;
            },
            onTap: () {
              print(songList[index]);
            },
            onLongPress: () async {
              final RenderBox overlay = Overlay.of(context).context.findRenderObject();
              showMenu(
                context: context,
                position: RelativeRect.fromRect(_tapPosition & const Size(40, 40), Offset.zero & overlay.size),
                items: [
                  PopupMenuItem(
                    value: 0,
                    child: Text("Edit"),
                  ),
                  PopupMenuItem(
                    value: 1,
                    child: Text("Delete"),
                  ),
                ],
              ).then((value) async {
                switch (value) {
                  case 0:
                    var returnMsg = await Navigator.pushNamed(context, "/songForm", arguments: songList[index]);
                    setState(() {
                      if (returnMsg != null) print(returnMsg);
                    });
                    break;
                  case 1:
                    _tryDeleteSongFromList(context, songList[index]);
                    break;
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          thickness: 2,
          color: Colors.black,
          height: 2,
        ),
      ),
      floatingActionButton: null,
    );
  }
}
