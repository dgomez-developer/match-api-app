

import 'package:match_api_app/auth/Credentials.dart';
import 'package:http/http.dart' as http;

import 'Cognito/src/cognito_credentials.dart';
import 'Cognito/sig_v4.dart';

// import the io version
import 'package:openid_client/openid_client_io.dart';
// use url launcher package
import 'package:url_launcher/url_launcher.dart';

class LoginApi {
  final String endpoint;
  final String path;
  final String region;
  final Credentials credentials;

  LoginApi(this.endpoint, this.path, this.region, this.credentials);

  post(Map body) async {
    CognitoCredentials cognitoCredentials = (await credentials.cognitoCredentials) as CognitoCredentials;
    final awsSigV4Client = new AwsSigV4Client(
      cognitoCredentials.accessKeyId,
      cognitoCredentials.secretAccessKey,
      endpoint,
      sessionToken: cognitoCredentials.sessionToken,
      region: region,
    );
    final signedRequest = new SigV4Request(
      awsSigV4Client,
      method: 'GET',
      path: path,
      // headers: new Map<String, String>.from({'header-1': 'one', 'header-2': 'two'}),
      // queryParams: new Map<String, String>.from({'tracking': 'x123'}),
      body: new Map<String, dynamic>.from(body),
    );

    http.Response response;

    response = await http.get(signedRequest.url, headers: signedRequest.headers);
    print(response.headers.toString());
    print(response.statusCode);
    print(response.body);
    return cognitoCredentials;
  }


  authenticate(Uri uri, String clientId, String clientSecret, List<String> scopes) async {

    // create the client
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId, clientSecret);

    // create a function to open a browser with an url
    urlLauncher(String url) async {
      if (await canLaunch(url)) {
        await launch(url, forceWebView: true);
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = new Authenticator(client,
        scopes: scopes,
        port: 4000, urlLancher: urlLauncher, redirectUri: Uri.parse("http://localhost:4000/"));

    // starts the authentication
    var c = await authenticator.authorize();

    // close the webview when finished
    closeWebView();

    print(c.idToken.toString());

    // return the user info
    return await c.getUserInfo();

  }



}