import 'package:flutter/material.dart';
import 'package:match_api_app/ChinesePingPongScreen.dart';
import 'package:match_api_app/MatchesListScreen.dart';
import 'package:match_api_app/UsersListScreen.dart';
import 'package:match_api_app/auth/Credentials.dart';

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
        title: Text("Match App"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.perm_identity),
            tooltip: 'Login',
            onPressed: () => {
//          Credentials credentials = new Credentials(
//          cognitoIdentityPoolId,
//          cognitoUserPoolId,
//          cognitoClientId,
//          googleSignInAuthentication.idToken,
//          'accounts.google.com',
//          );
//
//          final api = Api(apiEndpointUrl, '/flutter', 'ap-southeast-2', credentials);
//
//          final result = await api.post({});
//
//          print(result.body);
//
          },
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
}