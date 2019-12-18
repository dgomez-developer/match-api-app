import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:match_api_app/ChinesePingPongScreen.dart';
import 'package:match_api_app/MatchesListScreen.dart';
import 'package:match_api_app/UsersListScreen.dart';
import 'package:match_api_app/auth/Credentials.dart';
import 'package:match_api_app/auth/google.dart';

import 'ProfileScreen.dart';
import 'UserProfile.dart';
import 'auth/Cognito/cognito.dart';
import 'auth/LoginApi.dart';
import 'auth/Secret.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    MatchesListScreen(),
    UsersListScreen(),
    ChinesePingPongScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return createBottomBar();
  }


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Scaffold createBottomBar(){

    return Scaffold(
      appBar: AppBar(
        //title: Text("Match App"),
        title: Image.asset('images/logo3.jpg', fit: BoxFit.cover),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.perm_identity),
            tooltip: 'Login',
            onPressed: () => doLogin(),
          ),
        ],
      ),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Matches'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Players'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.stars),
              title: Text('Ranking')
          )
        ],
      ),
    );
  }

  doLogin() async {

    var secretLoader = SecretLoader(secretPath: "auth/secrets.json");
    var secrets = await secretLoader.load();
    final googleSignInAuthentication = await signInWithGoogle();

    print("ID_TOKEN: " + googleSignInAuthentication.idToken);
    print("ACCESS_TOKEN: " +googleSignInAuthentication.accessToken);

    Credentials credentials = new Credentials(
      secrets.cognitoIdentityPoolId,
      secrets.cognitoUserPoolId,
      secrets.cognitoClientId,
      googleSignInAuthentication.idToken
    );

    final api = LoginApi(secrets.apiEndpointUrl, '/maches', secrets.region, credentials);

    final cognitoCredentals = await api.post({}) as CognitoCredentials;

    final parts = googleSignInAuthentication.idToken.split('.');
    final payload = parts[1];
    final String decoded = B64urlEncRfc7515.decodeUtf8(payload);
    Map<String, dynamic> jwt = json.decode(decoded);

    pushUserProfile(UserProfile(
        jwt['name'],
        jwt['email'],
        jwt['picture'],
        googleSignInAuthentication.idToken,
        cognitoCredentals.sessionToken,
        cognitoCredentals.secretAccessKey,
        cognitoCredentals.secretAccessKey));
  }

  void pushUserProfile(UserProfile players) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => ProfileScreen(profile: players)),
    );
  }

}