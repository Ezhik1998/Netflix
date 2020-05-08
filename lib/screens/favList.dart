import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix/models/favList.dart';
import 'package:netflix/utils/themeNotifier.dart';
import 'package:provider/provider.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My List'),
        // backgroundColor: Colors.black,
      ),
      body: Container(
        // color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _FavList(),
              ),
            ),
            Divider(height: 4, color: themeNotifier.getTheme().dividerColor),
            // _ListRating()
          ],
        ),
      ),
    );
  }
}

class _FavList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movieNameStyle = Theme.of(context).textTheme.title;
    var list = Provider.of<FavListModel>(context);
    return FutureBuilder(
        future: list.getMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(FontAwesomeIcons.film),
                title: Text(
                  snapshot.data[index].name,
                  style: movieNameStyle,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
              "${snapshot.error}",
              style: TextStyle(fontSize: 26, color: Colors.red),
            ));
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}
