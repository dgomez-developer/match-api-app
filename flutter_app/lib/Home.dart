import 'package:flutter/material.dart';
import 'package:match_api_app/MatchesListScreen.dart';
import 'package:match_api_app/UsersListScreen.dart';

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
    UsersListScreen()
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