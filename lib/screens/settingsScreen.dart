import 'package:netflix/utils/themeNotifier.dart';
import 'package:netflix/constants/themeConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _darkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _darkTheme = (themeNotifier.getTheme() == darkTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Dark Theme', style: TextStyle(fontSize: 22)),
            contentPadding: const EdgeInsets.only(left: 16.0),
            trailing: Transform.scale(
              scale: 1.3,
              child: Switch(
                value: _darkTheme,
                onChanged: (val) {
                  // print(val);
                  setState(() {
                    _darkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  // void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
  //   (value)
  //       ? themeNotifier.setTheme(darkTheme)
  //       : themeNotifier.setTheme(lightTheme);
  //   var prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('darkMode', value);
  // }

   void onThemeChanged(bool value, ThemeNotifier themeNotifier) {    
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('darkMode', value);
    });
    // var prefs = await SharedPreferences.getInstance();
    // prefs.setBool('darkMode', value);
  }

}
