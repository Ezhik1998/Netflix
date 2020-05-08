import 'dart:async';
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/models/post.dart';
import 'package:netflix/models/affiche.dart';
import 'package:netflix/models/favList.dart';
import 'package:provider/provider.dart';

Future<Post> fetchPost() async {
  final response = await http.get('https://anapioficeandfire.com/api/books/1');
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load book info');
  }
}

class BookInfo extends StatelessWidget {
  final String title;
  final Movie movie;
  final int length;
  BookInfo({Key key, @required this.title, @required this.movie, this.length})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var affiche = Provider.of<AfficheModel>(context);
    var list = Provider.of<FavListModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => list.movies.length > length
                ? Navigator.pop(context, "${movie.name} was added to list")
                : (list.movies.length < length
                    ? Navigator.pop(
                        context, "${movie.name} was removed from list")
                    : Navigator.pop(context))),
        title: Text(title),
      ),
      body: Center(
        child: FutureBuilder<Post>(
          future: fetchPost(),
          builder: (context, snapshot) {
            // print(snapshot);
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(snapshot.data.name,
                        style: TextStyle(
                            fontSize: 24, fontStyle: FontStyle.italic)),
                    Text(snapshot.data.numberOfPages.toString(),
                        style: TextStyle(fontSize: 18)),
                    Text(snapshot.data.publisher,
                        style: TextStyle(fontSize: 20)),
                    Text(snapshot.data.country, style: TextStyle(fontSize: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[_AddButton(movie: affiche.getById(8))],
                    ),
                  ],
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
          },
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Movie movie;
  const _AddButton({Key key, @required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<FavListModel>(context);
    return FutureBuilder(
      future: list.getMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FlatButton(
            onPressed: snapshot.data.contains(movie)
                ? () => list.remove(movie)
                : () => list.add(movie),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                snapshot.data.contains(movie)
                    ? Icon(FontAwesomeIcons.check)
                    : Icon(FontAwesomeIcons.plus),
                SizedBox(
                  width: 10,
                ),
                snapshot.data.contains(movie) ? Text("Added") : Text("My List")
              ],
            ),
            // color: Colors.black12,
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
      },
    );
  }
}
