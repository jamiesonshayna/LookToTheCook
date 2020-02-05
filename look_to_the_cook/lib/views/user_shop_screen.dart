import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';

// ROUTES

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/04/2020
File Name: user_shop_screen.dart
Version: 2.0
Description: The purpose of this file is to build and render the user shopping list screen.
The screen.......... // TODO: BUILD OUT HEADER COMMENT WHEN SCREEN IS FINISHED
 */

class UserShopScreen extends StatelessWidget {
  static const String id = 'UserShop_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'SHOPPING LIST',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to home_screen
          },
        ),
      ),
    );
  }
}
