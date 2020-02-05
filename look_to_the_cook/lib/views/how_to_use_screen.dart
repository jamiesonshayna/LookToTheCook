import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import 'package:look_to_the_cook/templates/app_bar_component.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 01/30/2020
Last Modified: 02/04/2020
File Name: how_to_use_screen.dart
Version: 2.0
Description: The purpose of this file is to give the user a general-use guideline. Here
we will point out the features of the application, and their purposes. We will give small
instruction on how to add, delete, and update items that are held in inventory.
 */

// TODO: BUILD OUT UI AND COME UP WITH TEXT

class HowToUseScreen extends StatelessWidget {
  static const String id = 'howtouse_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: AppBarComponent(
          title: 'HOW TO USE',
          leftIcon: Icon(Icons.arrow_back_ios),
          invisibleRightIcon: true,
          leftOnPressed: () {
            Navigator.pop(context); // go back to settings_screen
          },
        ),
      ),
    );
  }
}