import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: form_text_fields.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class BackgroundContainerImage extends StatelessWidget {
  // properties of the container that can be customized
  final String image;
  final Widget child;

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