import 'package:flutter/material.dart';
import 'package:match_api_app/Home.dart';
import 'package:match_api_app/UsersListScreen.dart'; // Add this line.
import 'package:match_api_app/AppTabController.dart'; // Add this line.

void main() => runApp(MatchApp());

class MatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Match API',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
//        home: RandomWords()
//        home: UsersListScreen()
//        home: AppTabController.createTabController());
        home: Home());
  }
}
