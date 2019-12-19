import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Secret {
  final String s3Bucket;
  final String accessKey;
  final String secretKey;
  final String region;
  final String s3Endpoint;
  final String cognitoIdentityPoolId;
  final String cognitoUserPoolId;
  final String cognitoClientId;
  final String cognitoClientSecret;
  final String discoveryDocumentPath;
  final String discoveryDocumentBaseUrl;
  final String apiEndpointUrl;

  Secret({this.s3Bucket = "",
    this.accessKey = "",
    this.region = "",
    this.s3Endpoint = "",
    this.secretKey = "",
    this.cognitoIdentityPoolId = "",
    this.cognitoUserPoolId = "",
    this.cognitoClientId = "",
    this.cognitoClientSecret = "",
    this.discoveryDocumentBaseUrl = "",
    this.discoveryDocumentPath = "",
    this.apiEndpointUrl = ""});

  factory Secret.fromJson(Map<String, dynamic> jsonMap) {
    return new Secret(
        s3Bucket: jsonMap["s3Bucket"],
        accessKey: jsonMap["accessKey"],
        region: jsonMap["region"],
        s3Endpoint: jsonMap["s3Endpoint"],
        secretKey: jsonMap["secretKey"],
        cognitoIdentityPoolId: jsonMap["cognitoIdentityPoolId"],
        cognitoUserPoolId: jsonMap["cognitoUserPoolId"],
        cognitoClientId: jsonMap["cognitoClientId"],
        cognitoClientSecret: jsonMap["cognitoClientSecret"],
        discoveryDocumentBaseUrl: jsonMap["discoveryDocumentBaseUrl"],
        discoveryDocumentPath: jsonMap["discoveryDocumentPath"],
        apiEndpointUrl: jsonMap["apiEndpointUrl"]);
  }
}

class SecretLoader {
  final String secretPath;

  SecretLoader({this.secretPath});

  Future<Secret> load() {
    return rootBundle.loadStructuredData<Secret>(this.secretPath,
            (jsonStr) async {
          final secret = Secret.fromJson(json.decode(jsonStr));
          return secret;
        });
  }
}
