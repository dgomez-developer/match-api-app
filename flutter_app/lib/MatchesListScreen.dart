import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/AddMatchScreen.dart';
import 'package:match_api_app/MatchModel.dart';

class MatchesListScreen extends StatefulWidget {
  @override
  createState() => _MatchesListScreenState();
}

class _MatchesListScreenState extends State {
  var match = new List<MatchModel>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> _getMatches() {
    return API.getMatches().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        match = list.map((model) => MatchModel.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getMatches();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(
            itemCount: match.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                    ),
                    Text(match[index].player1.name),
                    Text(match[index].player1.score.toString())
                  ]),
                  Column(children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                    ),
                    Text(match[index].player2.name),
                    Text(match[index].player2.score.toString())
                  ])
                ],
              ));
            },
          ),
          onRefresh: _getMatches),
      floatingActionButton: FloatingActionButton(
        onPressed: pushCreateMatch,
        child: Icon(Icons.add),
      ),
    );
  }

  Route<dynamic> routeToCreateMatch() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return AddMatchScreen();
    });
  }

  void pushCreateMatch() {
    Navigator.of(context).push(routeToCreateMatch());
  }
}
