import "package:flutter/material.dart";
import "package:flutter_slidable/flutter_slidable.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/main_scaffold.dart";
import "package:ChoproReader/widgets/inherited_song_list.dart";

class SongListPage extends StatefulWidget {
  final List<Song> songList;
  final bool showArtist;

  SongListPage({this.songList = null, this.showArtist = true});

  @override
  _SongListPageState createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage> {
  Offset _tapPosition;

  Future<void> _tryEditSong(BuildContext context, Song song) async {
    var returnMsg = await Navigator.pushNamed(context, "/songForm", arguments: song);
    setState(() {
      if (returnMsg != null) print(returnMsg);
    });
  }

  Future<void> _tryDeleteSongFromList(BuildContext context, Song song) async {
    var ret = await _showDeleteDialog(context, song);
    if (!ret) return;
    print("Deleting song: $song");
    SongModel.deleteSong(song);

    MainScaffold.of(context).key.currentState.setState(() {});

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Deleted \"${song.title}\" from song list"),
        duration: Duration(seconds: 2),
      ),
    );
  }

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

  // @override
  // void initState() {
  //   super.initState();
  //   songList = widget.list;
  // }

  @override
  Widget build(BuildContext context) {
    var list = widget.songList ?? SongList.of(context);
    print(list);

    return ListView.separated(
      itemCount: list.length + 1,
      itemBuilder: (context, index) {
        if (index == list.length) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "${list.length} song${list.length != 1 ? "s" : ""}",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTapDown: (details) {
            _tapPosition = details.globalPosition;
          },
          onTap: () {
            print(list[index]);
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
                  _tryEditSong(context, list[index]);
                  break;
                case 1:
                  _tryDeleteSongFromList(context, list[index]);
                  break;
              }
            });
          },
          child: Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: SongWidget(song: list[index], showArtist: widget.showArtist),
            secondaryActions: [
              IconSlideAction(
                icon: Icons.delete,
                color: Colors.red,
                onTap: () => _tryDeleteSongFromList(context, list[index]),
              ),
              IconSlideAction(
                icon: Icons.edit,
                color: Colors.blue,
                onTap: () => _tryEditSong(context, list[index]),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Divider(
          thickness: 1,
          color: Colors.grey[700],
          height: 1,
        ),
      ),
    );
  }
}
