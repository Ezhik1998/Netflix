import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DownloadsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var movieNameStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Downloading'),
        // backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Icon(FontAwesomeIcons.download),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Gossip Girl",
                  style: movieNameStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("(S: 2, e:10)",
                    style:
                        movieNameStyle.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Icon(FontAwesomeIcons.download),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Harrow",
                  style: movieNameStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("(S: 1, e:8)",
                    style:
                        movieNameStyle.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 40,
                ),
                Icon(FontAwesomeIcons.download),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Wicked City",
                  style: movieNameStyle,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("(S: 1, e:5)",
                    style:
                        movieNameStyle.copyWith(fontStyle: FontStyle.italic)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
