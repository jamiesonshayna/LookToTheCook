import 'package:flutter/material.dart';
import 'views/landing_screen.dart';

void main() => runApp(LookToTheCookApp());

class LookToTheCookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Lato', // sets the app-wide font
      ),
      initialRoute: LandingScreen.id, // initial route when the app is loaded
      // navigation
      routes: {
        LandingScreen.id: (context) => LandingScreen(),
      },
    );
  }
}
