import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/27/2020
Last Modified: 02/27/2020
File Name: reset_password_class.dart
Version: 1.0
Description: This class handles the logic behind account password reset with AWS. It is used
on the profile_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to reset a current user's password
and change locally stored persistent data to match the new credentials.
 */
class ResetPassword {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();

  /*
  This method resets an AWS user account password.

  We first start a valid user session with the current user's password and
  email. If we have returned a valid session then we are able to attempt pw reset,
  and then if successful reset the user's local persistent data.
  @return Future<bool> true if success, false otherwise
   */
  Future<bool> resetUserPassword(String newPassword) async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
    username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;
    bool passwordChanged = false;

    try {
    session = await cognitoUser.authenticateUser(authDetails);

    // try to reset password after establishing a session
    passwordChanged = await cognitoUser.changePassword(await _storage.readFromStorage("password"), newPassword);

    await _storage.writeToStorage('password', newPassword);

    return passwordChanged;
    } catch (e) {
    print(e);
    return false;
    }
  }
}