import 'package:connectivity/connectivity.dart';
import 'dart:io';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/05/2020
Last Modified: 02/05/2020
File Name: internet_checker_class.dart
Version: 1.0
Description: This class component allows the application to check if there is connectivity.
It can check for mobile data, or wifi connection. Much of the functionality such as remote
database sync/pull, authentication, link loading, etc. needs connectivity so this class
is essential for determining which functionality can be performed.
 */
class InternetCheckerClass {
 /*
 This method checks for mobile internet connectivity.

 This method uses two packages to check if we have wifi or mobile data to
 perform various tasks throughout the app. If we have a connection this method
 tests navigation to google.com and if there is success we return true, otherwise
 we return false;

 @return T/F depending on if we have internet or not
  */
  hasConnection() async {
    var connectivityResult;
    try {
      connectivityResult = await (Connectivity().checkConnectivity());

      // check for wifi or mobile connectivity (at this point they may not actually work)
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile) {

        // actually try navigating to a website to make sure that the above
        // connections are valid and will work
        try {
          // connection success
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            return true;
          }
        }
        // connection failed
        on SocketException catch (_) {
          return false;
        }
      }
    }
    // catch any failure to eliminate app crash (debug and print e)
    catch(e) {
      print(e);
      return false;
    }
  }
}