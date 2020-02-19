import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: secure_storage_class.dart
Version: 1.0
Description: This class allows key and value private data to be stored locally in
the user's device. For iOS the device stores within the iOS keychain, and for
Android the data is stored with AES encryption and stored in keystore. This class allows
us to save passwords, emails, names, and data for auto-login functionality or other AWS
related functionality
 */

class SecureStorage {
  // storage object to read and write values
  FlutterSecureStorage _storage = new FlutterSecureStorage();

  /*
  This method writes a value to a key stored in secure storage.
  The value no matter what is stored as a string and must be cast if needed
  in a different format.

  @param key The key that we want our value associated with.
  @param value The value that we associate with our key.
   */
  writeToStorage(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /*
  This method allows us to read from secure storage on any device. Here we
  give a key and return a value associated with that key.

  @param key The key we want to use to search for our value.
  @return Future<String> the associated value.
   */
  Future<String> readFromStorage(String key) async {
    return await _storage.read(key: key);
  }
}