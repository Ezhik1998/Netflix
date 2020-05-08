import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:netflix/models/affiche.dart';
import 'package:netflix/models/favList.dart';
import 'package:netflix/screens/bookInfoScreen.dart';
import 'package:provider/provider.dart';
import 'package:netflix/utils/themeNotifier.dart';
import 'package:netflix/screens/movieDetailsScreen.dart';

final kTitleTextStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
final kDescriptionTextStyle =
    TextStyle(fontSize: 10, fontWeight: FontWeight.bold);

class RealHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var affiche = Provider.of<AfficheModel>(context);
    final list = Provider.of<FavListModel>(context);

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Tetiana Movlian"),
              accountEmail: Text("tmovlian@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : themeNotifier.getTheme().accentColor,
                child: Text(
                  "T",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            DrawerItem(
              icon: Icons.person,
              text: 'Account',
              action: () => Navigator.pop(context),
            ),
            DrawerItem(
              icon: Icons.favorite,
              text: 'My List',
              action: () {
                Navigator.pop(context);
                return Navigator.pushNamed(context, '/my-list');
              },
            ),
            DrawerItem(
              icon: Icons.monetization_on,
              text: 'Plans Info',
              action: () => Navigator.pop(context),
            ),
            DrawerItem(
              icon: Icons.settings,
              text: 'Settings',
              action: () {
                Navigator.pop(context);
                return Navigator.pushNamed(context, '/settings');
              },
            ),
            SizedBox(
              height: 170,
            ),
            Divider(),
            DrawerItem(
              icon: Icons.person_add,
              text: 'Invite friends',
              action: () => Navigator.pop(context),
            ),
            DrawerItem(
              icon: Icons.question_answer,
              text: 'Netflix FAQ',
              action: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/downloads'),
        child: Icon(FontAwesomeIcons.download),
      ),
      body: DefaultTabController(
        length: 1,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 415.0,
                floating: true,
                pinned: true,
                backgroundColor: Colors.grey,
                leading: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.bars,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                title: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, right: 20),
                    child: Image(image: AssetImage("images/Netflix_Logo.png")),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Series",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "Films",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/my-list'),
                    child: Text(
                      "My List",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                    background: Image(
                        image: AssetImage(affiche.getById(0).image),
                        fit: BoxFit.fill)),
                
              ),
            ];
          },
          body: ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _AddButton(movie: affiche.getById(0)),
                    FlatButton(
                      color: themeNotifier.getTheme().accentColor,
                      onPressed: () {},
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.play_arrow,
                            color: themeNotifier.getTheme().primaryColor,
                            size: 30,
                          ),
                          Text(
                            "Play",
                            style: TextStyle(
                              fontSize: 18,
                              color: themeNotifier.getTheme().primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.infoCircle),
                          Text("Info")
                        ],
                      ),
                    )
                  ],
                ),
              ),
              mostUsedCircle(context, "Previews"),
              mostUsedMovieWidget(
                context: context,
                theTitle: "Series",
                firstMovie: affiche.getById(9),
                secondMovie: affiche.getById(10),
                thirdMovie: affiche.getById(11),
                fourthMovie: affiche.getById(12),
                fifthMovie: affiche.getById(13),
                sixthMovie: affiche.getById(14),
                length: list.movies.length,
              ),
              mostUsedWidget(
                  theTitle: "Trending Now",
                  firstImage: "images/breaking_bad.jpg",
                  secondImage: "images/osmosis.jpg",
                  thirdImage: "images/black_mirror.jpg",
                  fourthImage: "images/planet_earth.jpg",
                  fifthImage: "images/peaky_blinders.jpg",
                  sixthImage: "images/american_crime_history.png"),
              uniqueWidget(context, "Available Now Part 1",
                  "images/white_gold.jpg", true),
              uniqueWidget(context, "HIT of the season",
                  "images/game_of_thrones.jpg", false),
              mostUsedWidget(
                  theTitle: "American Programmes",
                  firstImage: "images/hoc.jpg",
                  secondImage: "images/stranger.jpg",
                  thirdImage: "images/horse.jpg",
                  fourthImage: "images/crown.jpg",
                  fifthImage: "images/mindhunter.jpg",
                  sixthImage: "images/orange.jpg"),
              mostUsedWidget(
                  theTitle: "Netflix Originals",
                  firstImage: "images/godless.jpg",
                  secondImage: "images/narcos.jpg",
                  thirdImage: "images/orange.jpg",
                  fourthImage: "images/kimmy.jpg",
                  fifthImage: "images/black_mirror.jpg",
                  sixthImage: "images/crown.jpg"),
              mostUsedWidget(
                  theTitle: "Top picks for Tetiana",
                  firstImage: "images/wicked_city.jpg",
                  secondImage: "images/harrow.jpg",
                  thirdImage: "images/mentalist.jpg",
                  fourthImage: "images/forever.jpg",
                  fifthImage: "images/murder.jpg",
                  sixthImage: "images/GG-Poster.jpg"),
              mostUsedWidget(
                  theTitle: "New Release",
                  firstImage: "images/black_earth_rising.jpg",
                  secondImage: "images/russian_doll.jpg",
                  thirdImage: "images/turn_up.jpg",
                  fourthImage: "images/wicked_city.jpg",
                  fifthImage: "images/living.jpg",
                  sixthImage: "images/black_mirror_5.jpg"),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({this.icon, this.text, this.action});

  final String text;
  final IconData icon;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          text,
          style: TextStyle(fontSize: 18),
        ),
        onTap: () => action(),
      ),
    );
  }
}

Widget mostUsedCircle(BuildContext context, String theTitle) {
  var affiche = Provider.of<AfficheModel>(context);
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    height: 210,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            Text(
              theTitle,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              CircleAvatars(
                  id: 0,
                  image: "images/GG-Poster.jpg",
                  color: Colors.red,
                  movie: affiche.getById(0)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 2,
                  image: affiche.getById(2).image,
                  color: Colors.red,
                  movie: affiche.getById(2)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 3,
                  image: affiche.getById(3).image,
                  color: Colors.red,
                  movie: affiche.getById(3)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 4,
                  image: affiche.getById(4).image,
                  color: Colors.red,
                  movie: affiche.getById(4)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 5,
                  image: affiche.getById(5).image,
                  color: Colors.red,
                  movie: affiche.getById(5)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 6,
                  image: affiche.getById(6).image,
                  color: Colors.red,
                  movie: affiche.getById(6)),
              SizedBox(
                width: 10,
              ),
              CircleAvatars(
                  id: 7,
                  image: affiche.getById(7).image,
                  color: Colors.red,
                  movie: affiche.getById(7))
            ],
          ),
        )
      ],
    ),
  );
}

class CircleAvatars extends StatelessWidget {
  final Movie movie;
  final int id;
  final String image;
  final Color color;

  CircleAvatars({this.id, this.image, this.color, this.movie});

  @override
  Widget build(BuildContext context) {
    var list = Provider.of<FavListModel>(context);
    return FutureBuilder(
      future: list.getMovies(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GestureDetector(
            onLongPress:
                // print("Tapped $id");
                snapshot.data.contains(movie)
                    ? () => list.remove(movie)
                    : () => list.add(movie),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color:
                          (snapshot.data.contains(movie) ? Colors.blue : color),
                      width: 3)),
              child: CircleAvatar(
                backgroundImage: AssetImage(this.image),
                maxRadius: 70,
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
      },
    );
  }
}

Widget mostUsedMovieWidget(
    {BuildContext context,
    String theTitle,
    Movie firstMovie,
    Movie secondMovie,
    Movie thirdMovie,
    Movie fourthMovie,
    Movie fifthMovie,
    Movie sixthMovie,
    int length}) {
  var list = Provider.of<FavListModel>(context);
  return Container(
    height: 260,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              theTitle,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_9',
                    child: Image(image: AssetImage(firstMovie.image)),
                  ),
                ),
                onTap: () => _navigateMovieDetails(
                    context, firstMovie, list.movies.length, 'movie_9'),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => _navigateMovieDetails(
                    context, secondMovie, list.movies.length, 'movie_10'),
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_10',
                    child: Image(image: AssetImage(secondMovie.image)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => _navigateMovieDetails(
                    context, thirdMovie, list.movies.length, 'movie_11'),
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_11',
                    child: Image(image: AssetImage(thirdMovie.image)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => _navigateMovieDetails(
                    context, fourthMovie, list.movies.length, 'movie_12'),
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_12',
                    child: Image(image: AssetImage(fourthMovie.image)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => _navigateMovieDetails(
                    context, fifthMovie, list.movies.length, 'movie_13'),
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_13',
                    child: Image(image: AssetImage(fifthMovie.image)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => _navigateMovieDetails(
                    context, sixthMovie, list.movies.length, 'movie_14'),
                child: Container(
                  height: 160,
                  child: Hero(
                    tag: 'movie_14',
                    child: Image(image: AssetImage(sixthMovie.image)),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget mostUsedWidget(
    {String theTitle,
    String firstImage,
    String secondImage,
    String thirdImage,
    String fourthImage,
    String fifthImage,
    String sixthImage}) {
  return Container(
    height: 260,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 10,
            ),
            Text(
              theTitle,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(firstImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(secondImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(thirdImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(fourthImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(fifthImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 160,
                child: Image(
                  image: AssetImage(sixthImage),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget uniqueWidget(
    BuildContext context, String title, String image, bool mode) {
  var affiche = Provider.of<AfficheModel>(context);
  final themeNotifier = Provider.of<ThemeNotifier>(context);
  return Container(
    width: 720,
    height: 380,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        Container(
          height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage(image),
          )),
        ),
        Container(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FlatButton(
                  color: themeNotifier.getTheme().accentColor,
                  // color: Colors.white,
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.play_arrow,
                          color: themeNotifier.getTheme().primaryColor),
                      // Icon(Icons.play_arrow, color: Colors.black),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Play",
                        style: TextStyle(
                            fontSize: 20,
                            color: themeNotifier.getTheme().primaryColor),
                        // style: kTitleTextStyle.copyWith(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: mode
                    ? _AddAvailable(movie: affiche.getById(1))
                    : _ReadBookInfo(movie: affiche.getById(8)),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    ),
  );
}

_navigate(BuildContext context, Movie movie, int length) async {
  final mov = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookInfo(
              title: "'Ice and Fire' Book Info",
              movie: movie,
              length: length)));

  if (mov != null)
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("$mov"), duration: const Duration(seconds: 1)));
}

_navigateMovieDetails(
    BuildContext context, Movie movie, int length, String tag) async {
  final mov = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MovieDetails(),
          // Pass the arguments as part of the RouteSettings. The
          // MovieDetailsScreenArguments reads the arguments from these
          // settings.
          settings: RouteSettings(
              arguments: MovieDetailsScreenArguments(movie, length, tag))));
  if (mov != null)
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          content: Text("$mov"), duration: const Duration(seconds: 1)));
}

class _ReadBookInfo extends StatelessWidget {
  final Movie movie;
  const _ReadBookInfo({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var list = Provider.of<FavListModel>(context);
    return FlatButton(
      onPressed: () => _navigate(context, movie, list.movies.length),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.bookOpen),
          SizedBox(
            width: 10,
          ),
          Text(
            "Get book info",
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
      // color: Colors.black12,
    );
  }
}

class _AddAvailable extends StatelessWidget {
  final Movie movie;
  const _AddAvailable({Key key, @required this.movie}) : super(key: key);

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
            padding: EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                snapshot.data.contains(movie)
                    ? Icon(FontAwesomeIcons.check)
                    : Icon(FontAwesomeIcons.plus),
                snapshot.data.contains(movie) ? Text("Added") : Text("My List"),
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
    );
  }
}
