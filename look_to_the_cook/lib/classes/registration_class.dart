import 'package:firebase_auth/firebase_auth.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/18/2020
Last Modified: 02/18/2020
File Name: registration_class.dart
Version: 1.0
Description: The purpose of this class is to provide registration functionality with Google
Firebase. This allows the app user to sign up with an email and password using the correct files,
methods, and implementation and have their information sent and stored in Firebase database as a 'user'.
This way their attributes can be retrieved, they can confirm accounts via email, reset passwords, etc. This
class handles the private functionality that connects to Firebase.
 */

class Register {
  // auth private class variable for functionality
  final FirebaseAuth _auth = FirebaseAuth.instance;


  /*
  This method attempts to register a new user with email and password via Google Firebase.

  @param email The user's valid email
  @param password The user's valid password
  @return true if successful registration, false otherwise
   */
  Future<bool> doRegister(email, password) async {
      try {
        final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ))
            .user;
        return true;

      } catch(e) {
        print('could NOT register');
        print(e);
        return false;
      }
    }
}