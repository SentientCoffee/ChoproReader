import "package:flutter/material.dart";
import "package:ChoproReader/song.dart";

class SongSelectPage extends StatefulWidget {
  SongSelectPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SongSelectPageState createState() => _SongSelectPageState();
}

class _SongSelectPageState extends State<SongSelectPage> {
  List<Song> songList = [
    Song(title: "Song 1", author: "Author 1"),
    Song(title: "Song 2", author: "Author 2"),
  ];

  Offset _tapPosition;

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
                if (returnMsg != null) print(returnMsg);
              },
            ),
          ],
        ),
      ),
      body: ListView.separated(
        itemCount: songList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: SongWidget(song: songList[index]),
            onTapDown: (details) {
              _tapPosition = details.globalPosition;
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
                ],
              ).then((value) async {
                switch (value) {
                  case 0:
                    var returnMsg = await Navigator.pushNamed(context, "/songForm", arguments: songList[index]);
                    if (returnMsg != null) print(returnMsg);
                    break;
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 2, color: Colors.black),
      ),
      floatingActionButton: null,
    );
  }
}
