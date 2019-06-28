import 'package:flutter/material.dart';
import 'package:match_api_app/MatchesListScreen.dart';
import 'package:match_api_app/UsersListScreen.dart';

class AppTabController {
  
  static var view = TabBarView(
    children: [
      MatchesListScreen(),
      UsersListScreen(),
    ],
  );

  static DefaultTabController createTabController() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list)),
              Tab(icon: Icon(Icons.supervised_user_circle)),
            ],
          ),
          title: Text("Match App"),
        ),
        body: view,
      ),
    );
  }

}
