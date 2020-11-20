import 'package:ChoproReader/pages/song_form.dart';
import "package:flutter/material.dart";

import 'pages/song_list.dart';

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
      home: SongSelectPage(title: "Songs"),
      routes: {
        "/songForm": (context) => SongForm(),
      },
    );
  }
}
