import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: app_bar_component.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class AppBarComponent extends StatelessWidget {
  // properties of the app bar that can be customized
  final String title;
  final Icon leftIcon;
  final Icon rightIcon;
  final Function leftOnPressed;
  final Function rightOnPressed;
  final bool invisibleLeftIcon;
  final bool invisibleRightIcon;

  // constructor initializes the app bar with the inputted properties
  AppBarComponent({@required this.title, this.leftIcon, this.rightIcon,
    this.leftOnPressed, this.rightOnPressed,  this.invisibleLeftIcon,this.invisibleRightIcon});

  @override
  Widget build(BuildContext context) {

    return new Container(
      height: 100.0,
      child:   Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: leftOnPressed == null ? (){} : leftOnPressed,
            icon: leftIcon == null ? Icon(Icons.clear) : leftIcon,
            iconSize: 35.0,
            color: invisibleLeftIcon == true ? Color(0x00000000) : Colors.black,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 20.0, color: Colors.black),
          ),
          IconButton(
            onPressed: rightOnPressed == null ? (){} : rightOnPressed,
            icon: rightIcon == null ? Icon(Icons.clear) : rightIcon,
            iconSize: 35.0,
            color: invisibleRightIcon == true ? Color(0x00000000) : Colors.black,
          ),
        ],
      ),
    );
  }
}