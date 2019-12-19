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

  Widget _avatar = Positioned(top: 15.0,
      left: 15.0,
      child: Container(padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
          child: CircleAvatar(radius: 35.0,
              backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"))));

  Widget _avatar2 = Positioned(bottom: 15.0,
      right: 15.0,
      child: Container(padding: const EdgeInsets.all(3.0),
          decoration: new BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
          child: CircleAvatar(radius: 35.0,
              backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"))));

  Widget _player1Cup({index: int}) {
    return Positioned(top: 4, left: 65,

                      child: Image.asset("images/giphy2.gif",
                      //child: Image.asset("images/winner-cup.jpg",
                      fit: BoxFit.fitWidth,
                      width: match[index].player1.score > match[index].player2.score ? 80 : 0,
                      height: match[index].player1.score > match[index].player2.score ? 80 : 0)
    );
  }

  Widget _player2Cup({index: int}) {
    return Positioned(bottom: 7,
                      right: 73,
                      child: Image.asset("images/giphy2.gif",
                       fit: BoxFit.fitWidth,
                       width: match[index].player2.score > match[index].player1.score ? 80 : 0,
                       height: match[index].player2.score > match[index].player1.score ? 80 : 0)
    );
  }

  Widget _player1Data({index: int}) {
    return Positioned(
        left: 46,
        child: Column(children: <Widget>[
          Text(match[index].player1.name,
              style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          Text(match[index].player1.score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold))
        ])
    );
}

  Widget _player2Data({index: int}) {
    return Positioned(
        right: 60,
        child: Column(children: <Widget>[
          Text(match[index].player2.name,
              style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 0.5)),

          Text(match[index].player2.score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold))
        ]));
  }

  Widget _createCard({ index: int }) {
    return Card(borderOnForeground: false,
        elevation: 5,
        child: Column(mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(alignment: Alignment.center,
                children: <Widget>[
                  Material(elevation: 0.0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                          child: Image.asset("images/tennis-table-card-bg.jpg"))),
                  _avatar,
                  _avatar2,
                  _player1Cup(index: index),
                  _player2Cup(index: index),
                  _player1Data(index: index),
                  _player2Data(index: index)
                ],
              )]));
  }

  void _onSwipeLeft({ index: int }) {
    API.deleteMatch(match[index].id).then((dynamic) {
      setState(() {
        match.removeAt(index);
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Deleted")));
      });
    });
  }

  @override
  build(context) {
    return Scaffold(
      body: RefreshIndicator(
          key: _refreshIndicatorKey,
          child: ListView.builder(itemCount: match.length,
              itemBuilder: (context, index) {
                return Dismissible(key: Key(match[index].id),
                    onDismissed: (direction) { _onSwipeLeft(index: index);},
                    child: _createCard(index: index)
                );
              }
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
