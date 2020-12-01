import 'package:amazon_cognito_identity_dart_2/cognito.dart';

abstract class UserAuthService {
  Future<bool> signIn(String email, String password);
  Future<bool> confirmAccount(String email, String confirmationCode);
  Future<void> resendConfirmationCode(String email);
  Future<bool> checkAuthenticated();
  Future<bool> signUp(String email, String password);
  Future<void> signOut();
}

const awsUserPoolId = 'ap-southeast-2_RQo8DXiYi';
const awsClientId = '2qn30atjv2kqothtqrcq20b35s';

class AmplifyAuthServiceImpl implements UserAuthService {
  /// Login user
  Future<bool> signIn(String email, String password) async {
    try {
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);
      final cognitoUser = new CognitoUser(email, _userPool, storage: _userPool.storage);
      final authDetails = new AuthenticationDetails(
        username: email,
        password: password,
      );

      await cognitoUser.authenticateUser(authDetails);
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /// Confirm user's account with confirmation code sent to email
  Future<bool> confirmAccount(String email, String confirmationCode) async {
    try {
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);
      final cognitoUser = new CognitoUser(email, _userPool, storage: _userPool.storage);
      return await cognitoUser.confirmRegistration(confirmationCode);
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  /// Resend confirmation code to user's email
  Future<void> resendConfirmationCode(String email) async {
    try {
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);
      final cognitoUser = new CognitoUser(email, _userPool, storage: _userPool.storage);
      await cognitoUser.resendConfirmationCode();
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  /// Check if user's current session is valid
  Future<bool> checkAuthenticated() async {
    try {
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);
      final cognitoUser = await _userPool.getCurrentUser();
      if (cognitoUser != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  /// Sign up new user
  Future<bool> signUp(String email, String password) async {
    try {
      final userAttributes = [
        new AttributeArg(name: 'email', value: email),
      ];
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);

      final data = await _userPool.signUp(email, password, userAttributes: userAttributes);
      print(data);
      print(data.userConfirmed);
      print(data.user);
      print(data.user.username);
      return data!=null;
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future<void> signOut() async {
    try {
      final _userPool = CognitoUserPool(awsUserPoolId, awsClientId);
      final cognitoUser = await _userPool.getCurrentUser();
      await cognitoUser.signOut();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
