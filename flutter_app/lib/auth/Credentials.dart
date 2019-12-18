import 'dart:async';

import 'Cognito/src/cognito_credentials.dart';
import 'Cognito/src/cognito_user_pool.dart';

class Credentials {
  CognitoCredentials _cognitoCredentials;
  CognitoUserPool _cognitoUserPool;
  String _token;

  Credentials(
      String identityPoolId, String userPoolId, String clientId, this._token) {
    _cognitoUserPool = new CognitoUserPool(userPoolId, clientId);
    _cognitoCredentials =
        new CognitoCredentials(identityPoolId, _cognitoUserPool);
  }

  Future<CognitoCredentials> get cognitoCredentials async {
    await _cognitoCredentials.getAwsCredentials(_token, 'accounts.google.com');
    return _cognitoCredentials;
  }
}
