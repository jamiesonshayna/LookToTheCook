import 'package:flutter/material.dart';
import 'package:look_to_the_cook/templates/background_container_image.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';

class RegistrationScreen extends StatelessWidget {
  static const String id = 'registration_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainerImage(
        image: 'images/home_screen_bg.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}