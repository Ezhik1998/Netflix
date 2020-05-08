import 'package:flutter/foundation.dart';
import 'package:netflix/models/affiche.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavListModel extends ChangeNotifier {
  // The current affiche. Used to construct movies from numeric ids.
  final AfficheModel _affiche;

  // Internal, private state of the favList. Stores the ids of each movie.
  final List<int> _movieIds;

  String movIds = "";

  //
  String movTry = "";
  // 

  /// Construct a FavListModel instance that is backed by a [AfficheModel] and
  // an optional previous state of the favList.
  //
  /// If [previous] is not `null`, it's movies are copied to the newly
  // constructed instance.
  FavListModel(this._affiche, FavListModel previous)
      : assert(_affiche != null),
        _movieIds = previous?._movieIds ?? [];
        // movIds = 

  // List of movies in the favList.
  Future<List<Movie>> getMovies () async {
    var list = [];
    
    // 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var i in prefs.getString("ids").split("#")) {
      if (i != ""){        
        list.add(int.parse(i));
      }
    }

    // 
    // for (var i in movTry.split("#")) {
    //   print(i);
    //   if (i != "") {
    //     listTry.add(int.parse(i));
    //   }      
    // }
    // print(list);
    // print("List try");
    // print(listTry);    

    

    // print("List");
    // print(list);
    return list.map((id) => _affiche.getById(id)).toList();
    // return movies;
  }
  List<Movie> get movies =>
      _movieIds.map((id) => _affiche.getById(id)).toList();

  /// The current average rating of all movies in favList.
  /// fold - reduces a collection to a single value
  /// fold (initialValue, function)
  // double get averageRating => movies.length == 0
  //     ? 0.0
  //     : ((movies.fold(0, (total, current) => total + current.rating)) /
  //         movies.length);

  /// Adds [movie] to favList. This is the only way to modify the favList from outside.
  void add(Movie movie) {
    _movieIds.add(movie.id);
    _addMovieToPrefs(movie.id.toString());
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Movie movie) {
    _movieIds.remove(movie.id);  
    _removeMovieFromPrefs(movie.id.toString());  
    notifyListeners();
  }

  // _loadCounter() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();    
  //   return prefs.getString('ids') ?? "";    
  // }

  
  _addMovieToPrefs(_movieIds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      movIds = (prefs.getString("ids") ?? "") + _movieIds + "#";
      //
      movTry = (movTry ?? "") + _movieIds + "#";
      // print("MovTry add string");
      // print(movTry);
      // // 
      // print("String movIds add");
      // print(movIds);
      prefs.setString('ids', movIds);
      getMovies();    
  }

  _removeMovieFromPrefs(_movieIds) async {
    var list = [];
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    // print("Pref");
    // print(prefs.getString("ids")); 
    // print("Mov");
    // print(_movieIds);
      for (var i in (prefs.getString("ids") ?? "").split("#")) {
        print(i);
        if (i != _movieIds) {
          list.add(i);
        }
      }
      // 
      // for (var i in movTry.split("#")) {
      //   if (i != _movieIds) {
      //     listTry.add(i);
      //   }
      // }
      // movTry = listTry.join("#");
      // print("Join");
      // print(movTry);
      // 
      movIds = list.join("#");
      // print("String movIds remove");  
      // print(movIds);
      prefs.setString('ids', movIds);
      getMovies();    
  }
}
