import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/19/2020
Last Modified: 02/19/2020
File Name: login_logout_class.dart
Version: 1.0
Description: This class handles the logic behind authentication with AWS. It is used on the
login_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to register a user, confirm/verify
their account, and then send success messages back to the view.
 */
class LoginLogout {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();

  //String error = "";

  /*
  This method creates a session for the user that has just been registered and confirmed.
  If we return true the user is taken to the home page with valid credentials.

  @return True if we have a valid AWS session, false otherwise.
   */
  Future<bool> autoAuthenticateAndLogin() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;

    try {
      session = await cognitoUser.authenticateUser(authDetails);
      //getAndSetAttributes(cognitoUser);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  getAndSetAttributes(CognitoUser cognitoUser) async {
    List<CognitoUserAttribute> attributes;

    try {
      attributes = await cognitoUser.getUserAttributes();

      attributes.forEach((attribute) {
        if(attribute.getName().toString() == "name") {
          print(attribute.getValue().toString());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}