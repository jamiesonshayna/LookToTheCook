import 'package:flutter/material.dart';

/*
Authors: Shayna Jamieson & Rob Wood
Date Created: 1/30/2019
Last Modified: 1/30/2019
File Name: form_text_fields.dart
Version: 1.0

Description: This file is part of the templates directory.
 */

class FormTextField extends StatelessWidget {
  // properties to be inputted
  final String text;

  // constructor for component that sets the text child
  FormTextField(this.text);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: const InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        icon: Icon(
          Icons.person,
          color: Colors.orangeAccent,
        ),
        hintText: '',
        labelText: '',
        labelStyle: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}