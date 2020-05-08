import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:netflix/models/affiche.dart';
import 'package:netflix/models/favList.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreenArguments {
  final Movie movie;
  final int length;
  final String tag;

  MovieDetailsScreenArguments(this.movie, this.length, this.tag);
}

class MovieDetails extends StatelessWidget {
  static const routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<FavListModel>(context);
    final MovieDetailsScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => list.movies.length > args.length
                ? Navigator.pop(context, "${args.movie.name} was added to list")
                : (list.movies.length < args.length
                    ? Navigator.pop(
                        context, "${args.movie.name} was removed from list")
                    : Navigator.pop(context))),
        title: Text(args.movie.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 380,
              child: Hero(
                tag: args.tag,
                child: Image(
                  image: AssetImage(args.movie.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.stars),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${args.movie.rating}",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text('${args.movie.year}', style: TextStyle(fontSize: 20)),
                SizedBox(
                  width: 15,
                ),
                Text('${args.movie.duration}', style: TextStyle(fontSize: 20)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "${args.movie.description}",
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _AddButton(movie: args.movie),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star_border),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rate",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.file_download),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Download",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          ],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                snapshot.data.contains(movie)
                    ? Icon(FontAwesomeIcons.check)
                    : Icon(FontAwesomeIcons.plus),
                SizedBox(
                  height: 10,
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
