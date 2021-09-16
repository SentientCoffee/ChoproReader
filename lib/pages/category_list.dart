import "package:flutter/material.dart";
import "package:ChoproReader/song.dart";
import "package:ChoproReader/pages/song_submenu_scaffold.dart";
import "package:ChoproReader/widgets/song_list.dart";

class CategoryListPage extends StatefulWidget {
  CategoryListPage();

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  @override
  Widget build(BuildContext context) {
    List<Song> songList = SongList.of(context).songList;
    List<String> categoryList = [];

    for (var song in songList) {
      for (var category in song.categories) {
        if (categoryList.contains(category)) continue;
        categoryList.add(category);
      }
    }

    return ListView.separated(
      itemCount: categoryList.length + 1,
      itemBuilder: (context, index) {
        if (index == categoryList.length) {
          return Center(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "${categoryList.length} categories",
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
            for (var song in songList) {
              if (!song.categories.contains(categoryList[index])) continue;
              list.add(song);
            }

            var returnMsg = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongSubmenuScaffold(
                  title: "Category: ${categoryList[index]}",
                  songList: list,
                  showCategories: false,
                ),
              ),
            );
            if (returnMsg != null) print(returnMsg);
          },
          child: ListTile(title: Text(categoryList[index])),
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
