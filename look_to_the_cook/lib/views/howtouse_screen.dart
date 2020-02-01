import 'package:flutter/material.dart';
import 'package:look_to_the_cook/templates/background_container_image.dart';
import 'package:look_to_the_cook/templates/rounded_button.dart';
import 'package:look_to_the_cook/views/registration_screen.dart';

class HowToUseScreen extends StatelessWidget {
  static const String id = 'howtouse_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainerImage(
        image: 'images/home_screen_bg.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: SizedBox(),),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: RoundedButton(
              title: 'LOG IN',
              buttonColor: Colors.white,
              buttonTextColor: Colors.black,
              onPressed: () {

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 50.0, top: 10.0),
            child: RoundedButton(
              title: 'REGISTER',
              buttonColor: Colors.white,
              buttonTextColor: Colors.black,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },
            ),
          ),
        ],
        ),
      ),
    );
  }
}
