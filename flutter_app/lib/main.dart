import 'package:flutter/material.dart';
import 'package:match_api_app/Home.dart';

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
        home: Home());
  }
}
