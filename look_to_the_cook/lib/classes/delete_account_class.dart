import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:look_to_the_cook/classes/secure_storage_class.dart';

/*
Authors: Shayna Jamieson, Rob Wood
Date Created: 02/27/2020
Last Modified: 02/27/2020
File Name: delete_account_class.dart
Version: 1.0
Description: This class handles the logic behind account deletion with AWS. It is used on the
profile_screen.dart view. This class connects to the AWS user pool and client. Here we
can use those along with the client provided credentials to permanently delete a user account,
delete secure storage settings.
 */
class DeleteAccount {
  // private fields
  CognitoUserPool _userPool = new CognitoUserPool("us-west-2_dscLXwSqb", "23nvu4t7pejbifgb6jndgvula9");
  SecureStorage _storage = new SecureStorage();


  /*
  This method permanently deletes an AWS user account.

  We first start a valid user session with the current user's password and
  email. If we have returned a valid session then we are able to attempt deletion,
  and take the users credentials out of local persistent storage.
  @return Future<bool> true if success, false otherwise
   */
  Future<bool> deleteUserAccount() async {
    // create cognito user object - used for AWS functionality
    final cognitoUser = new CognitoUser(
        await _storage.readFromStorage("email"), _userPool);

    final authDetails = new AuthenticationDetails(
        username: await _storage.readFromStorage("email"), password: await _storage.readFromStorage("password"));

    CognitoUserSession session;
    bool userDeleted = false;

    try {
      session = await cognitoUser.authenticateUser(authDetails);

      // try to delete account
      userDeleted = await cognitoUser.deleteUser();

      await _storage.writeToStorage('name', '');
      await  _storage.writeToStorage('email', '');
      await _storage.writeToStorage('password', '');

      return userDeleted;
    } catch (e) {
      print(e);
      return false;
    }
  }
}