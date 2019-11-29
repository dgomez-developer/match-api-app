import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';

class AddMatchScreen extends StatefulWidget {
  final List<Player> players;

  AddMatchScreen({Key key, @required this.players}) : super(key: key);

  @override
  AddMatchScreenState createState() {
    return AddMatchScreenState(players: players);
  }
}

class AddMatchScreenState extends State<AddMatchScreen> {
  final _screenKey = GlobalKey<ScaffoldState>();
  final _firstPlayerScoreController = TextEditingController();
  final _secondPlayerScoreController = TextEditingController();
  Player _secondPlayer;
  final List<Player> players;
  Player _firstPlayer;

  AddMatchScreenState({@required this.players}){
    _firstPlayer = players.elementAt(0);
    _secondPlayer = players.elementAt(1);
  }

  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        key: _screenKey,
        appBar: AppBar(
          title: Text("Create Match"),
        ),
        body: Column(children: <Widget>[
          Text("First Player"),
          DropdownButton(
            hint: Text('Please choose a player'),
            value: _firstPlayer,
            onChanged: (Player newValue) {
              _firstPlayer = newValue;
              setState(() {});
            },
            items: players.map((player) {
              return new DropdownMenuItem(
                value: player,
                child: new Text(player.name),
              );
            }).toList(),
          ),
          Row(
            children: <Widget>[
              Text("Score"),
              new Flexible(
                  child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: _firstPlayerScoreController,
              ))
            ],
          ),
          Text("Second Player"),
          DropdownButton(
            value: _secondPlayer,
            hint: Text('Please choose a player'),
            onChanged: (Player newValue) {
              _secondPlayer = newValue;
              setState(() {});
            },
            items: players.map((player) {
              return new DropdownMenuItem(
                value: player,
                child: new Text(player.name),
              );
            }).toList(),
          ),
          Row(
            children: <Widget>[
              Text("Score"),
              new Flexible(
                  child: TextField(
                keyboardType: TextInputType.number,
                maxLines: 1,
                controller: _secondPlayerScoreController,
              ))
            ],
          ),
          RaisedButton(
            onPressed: () {

                var match = MatchModel();
                var player1 = Player();
                player1.name = _firstPlayer.name;
                player1.score = int.parse(_firstPlayerScoreController.text);
                match.player1 = player1;
                var player2 = Player();
                player2.name = _secondPlayer.name;
                player2.score = int.parse(_secondPlayerScoreController.text);
                match.player2 = player2;
                API.createMatches(match).then((response) {
                  _screenKey.currentState
                      .showSnackBar(SnackBar(content: Text('Match created')));
                });

            },
            child: Text("Create"),
          )
        ]));
  }
}
