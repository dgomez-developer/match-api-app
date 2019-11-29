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
              return Dismissible(
                  key: Key(match[index].id),
                  onDismissed: (direction) {
                    API.deleteMatch(match[index].id).then((dynamic) {
                      setState(() {
                        match.removeAt(index);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("Deleted")));
                      });
                    });
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                      borderOnForeground: true,
                      elevation: 5,
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Material(
                                elevation: 0.0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0)),
                                  child: Image.asset(
                                      "images/tennis-table-card-bg.jpg"),
                                )),
                            Material(
                                elevation: 1.0,
                                color: Colors.transparent,
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child:  ListTile(
                                            title:
                                             Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                                 Image.asset(
                                                     "images/winner-cup.jpg",
                                                     fit: BoxFit.fitWidth,
                                                     width: match[index].player1.score > match[index].player2.score ? 50 : 0,
                                                     height: match[index].player1.score > match[index].player2.score ? 50 : 0),
                                             Container(
                                             color: Colors.transparent,
                                               child:
                                            Column(children: <Widget>[
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "https://i.imgur.com/BoN9kdC.png"),
                                              ),
                                              Text(match[index].player1.name),
                                              Text(match[index]
                                                  .player1
                                                  .score
                                                  .toString())
                                            ])),
                                        Container(
                                          color: Colors.transparent,
                                          child:
                                            Column(children: <Widget>[
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    "https://i.imgur.com/BoN9kdC.png"),
                                              ),
                                              Text(match[index].player2.name),
                                              Text(match[index]
                                                  .player2
                                                  .score
                                                  .toString())

                                            ])),
                                            Image.asset(
                                                "images/winner-cup.jpg",
                                                fit: BoxFit.fitWidth,
                                                width: match[index].player2.score > match[index].player1.score ? 50 : 0,
                                                height: match[index].player2.score > match[index].player1.score ? 50 : 0)
                                          ],
                                        ))))
                          ],
                        )
                      ])));
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
