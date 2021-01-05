import "package:ChoproReader/song.dart";
import "package:flutter/material.dart";

class SongForm extends StatefulWidget {
  SongForm({Key key}) : super(key: key);

  @override
  createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  Future<bool> _showDiscardDialog(BuildContext context) async {
    var ret = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Discard?"),
        content: Text("Leave without saving changes?"),
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

  @override
  Widget build(BuildContext context) {
    final Song oldSong = ModalRoute.of(context).settings.arguments;

    var _pageTitle = oldSong == null ? "Add song" : "Edit song";
    var _songTitle = oldSong?.title ?? "";
    var _songArtist = oldSong?.artist ?? "";

    return WillPopScope(
      onWillPop: () async {
        var ret = await _showDiscardDialog(context);
        //
        // Mega @Ugh @CodeSmell
        // Maybe there's a better way to do this so that it doesn't pop twice
        // but still returns through the navigator?
        //
        if (ret) print("Cancelled editing: ${oldSong ?? "New song"}");
        return ret;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _showDiscardDialog(context)) {
                Navigator.of(context).pop("Cancelled editing: ${oldSong ?? "New song"}");
              }
            },
          ),
          title: Text(_pageTitle),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _songTitle,
                  decoration: InputDecoration(
                    labelText: "Song title",
                  ),
                  onChanged: (text) => _songTitle = text,
                ),
                TextFormField(
                  initialValue: _songArtist,
                  decoration: InputDecoration(
                    labelText: "Artist",
                  ),
                  onChanged: (text) => _songArtist = text,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            // @Incomplete: Implement returning song to song list, maybe implement database first?
            Navigator.of(context).pop("Saving: ${Song(title: _songTitle, artist: _songArtist)}");
          },
        ),
      ),
    );
  }
}
