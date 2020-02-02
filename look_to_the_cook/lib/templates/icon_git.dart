import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class IconGit extends StatelessWidget {
  final String link;

  IconGit(
    {@required this.link
    });

  Widget build(BuildContext context) {
      return new IconButton(
        // Use the FontAwesomeIcons class for the IconData
          icon: new Icon(FontAwesomeIcons.github),
          onPressed: () {
            _launchURL(link);
          }
      );
  }
  _launchURL(String url) async {
    launch(url);
  }
}


//   'https://www.linkedin.com/in/sourabh-kumar-08987560/'),
//