import "package:flutter/material.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/utils.dart";

class SongForm extends StatefulWidget {
  final Song oldSong;

  SongForm({Key key, this.oldSong = null}) : super(key: key);

  @override
  createState() => _SongFormState();
}

class _SongFormState extends State<SongForm> {
  String _pageTitle;

  String _songTitle;
  String _songArtist;
  String _newSongCategory;
  List<String> _songCategories;

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
  void initState() {
    super.initState();

    _pageTitle = widget.oldSong == null ? "Add song" : "Edit song";
    _songTitle = widget.oldSong?.title ?? "";
    _songArtist = widget.oldSong?.artist ?? "";
    _songCategories = widget.oldSong?.categories ?? [];
    _newSongCategory = "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var ret = await _showDiscardDialog(context);
        //
        // Mega @Ugh @CodeSmell
        // Maybe there's a better way to do this so that it doesn't pop twice
        // but still returns through the navigator?
        //
        if (ret) print("Cancelled editing: ${widget.oldSong ?? "New song"}");
        return ret;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _showDiscardDialog(context)) {
                Navigator.of(context).pop("Cancelled editing: ${widget.oldSong ?? "New song"}");
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: _newSongCategory,
                      decoration: InputDecoration(
                        labelText: "Category",
                      ),
                      onChanged: (text) => _newSongCategory = text,
                    ),
                  ),
                  FlatButton(
                    onPressed: () => setState(() {
                      if (_newSongCategory.isEmpty) return;
                      if (_songCategories.contains(_newSongCategory)) return;
                      _songCategories.add(_newSongCategory);
                    }),
                    child: Text(
                      "Add",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
              // @Incomplete: make sure it scrolls properly
              Expanded(
                child: Container(
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
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: () {
            if (widget.oldSong == null) {
              SongModel.insertSong(Song(title: _songTitle, artist: _songArtist, categories: _songCategories));
            } else {
              widget.oldSong.title = _songTitle;
              widget.oldSong.artist = _songArtist;
              widget.oldSong.categories = _songCategories;
              SongModel.updateSong(widget.oldSong);
            }
            Navigator.of(context).pop("Saving: ${Song(title: _songTitle, artist: _songArtist)}");
          },
        ),
      ),
    );
  }
}
