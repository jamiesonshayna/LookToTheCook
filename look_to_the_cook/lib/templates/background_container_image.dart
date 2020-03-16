import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2020
Last Modified: 2/04/2020
File Name: background_container_image.dart
Version: 2.0
Description: This file creates our Background Container Image Component that is used app-wide. This
component is used on any screens that need an asset image displayed as the background for the entire
scaffold (instead of solid colors). To use this component, import this dart file on the page where you
would like to use it and instantiate the BackgroundContainerImage() (only required parameter is the image).
 */
class BackgroundContainerImage extends StatelessWidget {
  final String image; // image url to use for background
  final Widget child; // container, body, etc.

  // constructor initializes the app bar with the inputted properties
  BackgroundContainerImage({@required this.image, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: child != null ? child : null);  // no child if none given
  }
}