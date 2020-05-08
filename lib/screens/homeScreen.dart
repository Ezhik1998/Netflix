import 'package:flutter/material.dart';
import 'package:netflix/screens/affiche.dart';
import 'package:netflix/screens/downloadsScreen.dart';
import 'package:netflix/screens/favList.dart';
import 'package:netflix/screens/settingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:netflix/models/affiche.dart';
import 'package:netflix/models/favList.dart';
import 'package:netflix/utils/themeNotifier.dart';
import 'package:netflix/screens/movieDetailsScreen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, AfficheModel never changes, so a simple Provider
        // is sufficient.
        Provider(builder: (context) => AfficheModel()),
        // FavListModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, FavListModel depends
        // on AfficheModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<AfficheModel, FavListModel>(
            builder: (context, affiche, previousFavList) =>
                FavListModel(affiche, previousFavList))
      ],
      child: MaterialApp(        
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        // theme:
        //     ThemeData(primaryColor: Colors.black, brightness: Brightness.dark),
        initialRoute: '/',
        routes: {
          '/': (context) => RealHomePage(),
          '/my-list': (context) => MyList(),
          '/downloads': (context) => DownloadsPage(),
          '/settings': (context) => SettingsPage(),
          MovieDetails.routeName: (context) => MovieDetails(),
        },
      ),
    );
  }
}
