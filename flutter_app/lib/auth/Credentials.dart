import 'dart:async';
import 'package:amazon_cognito_identity_dart/cognito.dart';
import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import 'package:http/http.dart' as http;

class Credentials {
  final CognitoCredentials _cognitoCredentials;
  final String _token;
  final String _authenticator;

  Credentials(String identityPoolId, String userPoolId, String clientId, this._token, [this._authenticator])
      : _cognitoCredentials = new CognitoCredentials(identityPoolId, new CognitoUserPool(userPoolId, clientId));

  Future<CognitoCredentials> get cognitoCredentials async {
    await _cognitoCredentials.getAwsCredentials(_token);
    return _cognitoCredentials;
  }
}