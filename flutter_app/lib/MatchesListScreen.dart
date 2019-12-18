import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/AddMatchScreen.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';


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
                  child: Card(
                      borderOnForeground: false,
                      elevation: 5,
                      child: Column(mainAxisSize: MainAxisSize.min, children: <
                          Widget>[
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Material(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(10.0)),
                                  child: Image.asset(
                                      "images/tennis-table-card-bg.jpg"),
                                )),

                            Positioned(
                              child: Container(
                                  child: CircleAvatar(
                                    radius: 35.0,
                                    backgroundImage: NetworkImage(
                                        "https://i.imgur.com/BoN9kdC.png"),
                                  ),

                                  padding: const EdgeInsets.all(3.0), // borde width
                                  decoration: new BoxDecoration(
                                    color: Colors.redAccent, // border color
                                    shape: BoxShape.circle,
                                  )
                              ),
                              top: 15,
                              left: 15,
                            ),

                            Positioned(
                              child: Container(
                                child: CircleAvatar(
                                  radius: 35.0,
                                  backgroundImage: NetworkImage(
                                      "https://i.imgur.com/BoN9kdC.png"),
                                ),

                                padding: const EdgeInsets.all(3.0), // borde width
                                decoration: new BoxDecoration(
                                  color: Colors.redAccent, // border color
                                  shape: BoxShape.circle,
                                )
                              ),
                              bottom: 15,
                              right: 12,
                            ),

                            Positioned(
                              top: 15,
                              left: 70,
                              child: Image.asset("images/winner-cup.jpg",
                                  fit: BoxFit.fitWidth,
                                  width: match[index].player1.score >
                                      match[index].player2.score
                                      ? 50
                                      : 0,
                                  height: match[index].player1.score >
                                      match[index].player2.score
                                      ? 50
                                      : 0),
                            ),

                            Positioned(
                              bottom: 15,
                              right: 75,
                              child: Image.asset("images/winner-cup.jpg",
                                  fit: BoxFit.fitWidth,
                                  width: match[index].player2.score >
                                      match[index].player1.score
                                      ? 50
                                      : 0,
                                  height: match[index].player2.score >
                                      match[index].player1.score

                                      ? 50
                                      : 0),
                            ),

                            Positioned(
                                left: 46,
                                child: Column(children: <Widget>[
                                  Text(match[index].player1.name,
                                    style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 0.5),),
                                  Text(match[index]
                                      .player1
                                      .score
                                      .toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
                                ])
                            ),

                            Positioned(
                              right: 60,
                                child: Column(children: <Widget>[
                                  Text(match[index].player2.name,
                                    style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 0.5),),

                                  Text(match[index]
                                      .player2
                                      .score
                                      .toString(),
                                    style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),)
                                ])),
                            
                            ],
                        )
                      ])));
            },
          ),
          onRefresh: _getMatches),
      floatingActionButton: FloatingActionButton(
        onPressed: getPlayersAndPush,
        child: Icon(Icons.add),
        backgroundColor: Colors.green.shade800,),
    );
  }




  Route<dynamic> routeToCreateMatch(List<Player> players) {
    return MaterialPageRoute(builder: (BuildContext context) {
        return AddMatchScreen(players: players);
    });
  }

  void getPlayersAndPush(){
    API.getPlayers().then((players) {
      pushCreateMatch(players);
    });
  }

  void pushCreateMatch(List<Player> players) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => AddMatchScreen(players: players)),
    );

    if (result == true) {
      this._getMatches();
    }

    //Navigator.of(context).push(routeToCreateMatch(players));
  }
}
