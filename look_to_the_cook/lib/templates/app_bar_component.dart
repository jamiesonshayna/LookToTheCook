import 'package:flutter/material.dart';

// TEMPLATE COMPONENTS:
import'constants.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 2/04/2020
File Name: app_bar_component.dart
Version: 2.0

Description: This file creates our App Bar Component that is used app-wide. This allows
us to input desired App Bar properties on each screen with just a class instantiation. All inputted
properties are taken into account when the App Bar is rendered. Here we can customize the icons, text, as well
as if there are just 1 or 2 icons. To use this component, import this dart file on the page where you
would like to use it and instantiate the AppBarComponent() (only required parameter is the title).
 */

class AppBarComponent extends StatelessWidget {
  // custom properties for the AppBarComponent class
  final String title; // text displayed on the App Bar
  final Icon leftIcon; // how icon displays
  final Icon rightIcon;
  final Function leftOnPressed; // action when left/right icons are pressed
  final Function rightOnPressed;
  final bool invisibleLeftIcon; // hide left or right icons
  final bool invisibleRightIcon;

  // constructor initializes the app bar with the inputted properties
  AppBarComponent({@required this.title, this.leftIcon, this.rightIcon,
    this.leftOnPressed, this.rightOnPressed,  this.invisibleLeftIcon,this.invisibleRightIcon});

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: kRedButtonColor,
      height: 100.0,
      child:   Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton( // display or hide the left App Bar icon
              onPressed: leftOnPressed == null ? (){} : leftOnPressed,
              icon: leftIcon == null ? Icon(Icons.clear) : leftIcon,
              iconSize: 35.0,
              color: invisibleLeftIcon == true ? Color(0x00000000) : Colors.white,
            ),
            Text( // App Bar title (displayed)
              title,
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            IconButton( // display or hide the right App Bar icon
              onPressed: rightOnPressed == null ? (){} : rightOnPressed,
              icon: rightIcon == null ? Icon(Icons.clear) : rightIcon,
              iconSize: 35.0,
              color: invisibleRightIcon == true ? Color(0x00000000) : Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}