import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:netflix/utils/themeNotifier.dart';
import 'package:netflix/constants/themeConstants.dart';
import 'package:netflix/screens/homeScreen.dart';

void main() {  
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    // if prefs.getBool('darkMode') is NULL (first start app) darkModeOn = true    
    var darkModeOn = prefs.getBool('darkMode') ?? true;
    
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        builder: (_) => ThemeNotifier(darkModeOn ? darkTheme : lightTheme),
        child: Netflix(),
      ),
    );
  });
}

class Netflix extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      theme: themeNotifier.getTheme(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(FontAwesomeIcons.home),
              text: "Home",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.search),
              text: "Search",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.tv),
              text: "Soon",
            ),
            Tab(
              icon: Icon(FontAwesomeIcons.download),
              text: "Download",
            ),
            Tab(              
              icon: Icon(FontAwesomeIcons.bars),
              text: "Menu",
            ),
          ],
          // unselectedLabelColor: Color(0xFF999999),
          // labelColor: Colors.white,
          indicatorColor: Colors.transparent,
        ),
        body: TabBarView(children: [
          HomePage(),
          Center(child: Text("Search")),
          Center(child: Text("Soon")),
          Center(child: Text("Download")),
          Center(child: Text("Menu")),
        ]),
      ),
      // ),
    );
  }
}
