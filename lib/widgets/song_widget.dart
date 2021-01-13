import "package:flutter/material.dart";
import "package:ChoproReader/song.dart";

class SongWidget extends StatelessWidget {
  final Song song;
  final bool showArtist;
  final bool showCategories;

  SongWidget({
    this.song,
    this.showArtist = true,
    this.showCategories = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                song.title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                child: !showArtist
                    ? null
                    : Text(
                        song.artist,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ),
            ],
          ),
          Container(
            child: !showCategories
                ? null
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: song.categories.map((category) {
                      return Text(
                        category,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
