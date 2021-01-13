import "package:flutter/material.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/utils.dart";

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
    var _songCategories = oldSong?.categories ?? [];
    var _newSongCategory = "";

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
        body: Container(
          padding: EdgeInsets.all(16.0),
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
              Utils.buildSpace(height: 30.0),
              TextFormField(
                initialValue: _newSongCategory,
                decoration: InputDecoration(
                  labelText: "Category",
                ),
                onChanged: (text) => _newSongCategory = text,
              ),
              // @Incomplete: make sure it scrolls properly
              Container(
                height: 200.0,
                padding: EdgeInsets.all(10.0),
                child: Scrollable(
                  viewportBuilder: (context, offset) => ListView.builder(
                    itemCount: _songCategories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 12.0),
                              color: Theme.of(context).colorScheme.primary,
                              child: Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Text(_songCategories[index]),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if (oldSong == null) {
              SongModel.insertSong(Song(title: _songTitle, artist: _songArtist));
            } else {
              oldSong.title = _songTitle;
              oldSong.artist = _songArtist;
              SongModel.updateSong(oldSong);
            }
            Navigator.of(context).pop("Saving: ${Song(title: _songTitle, artist: _songArtist)}");
          },
        ),
      ),
    );
  }
}
