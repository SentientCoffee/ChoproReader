import "package:flutter/material.dart";

import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/main_scaffold.dart";
import "package:ChoproReader/pages/settings.dart";
import "package:ChoproReader/pages/song_form.dart";

void main() => runApp(Application());

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ChordPro Songbook",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScaffold(title: "ChordPro Songbook"),
      routes: {
        "/songForm": (context) => SongForm(oldSong: ModalRoute.of(context).settings.arguments as Song),
        "/settings": (context) => SettingsPage(),
      },
    );
  }
}
