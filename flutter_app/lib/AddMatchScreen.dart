import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Color _textStyleColor = Colors.green;

  void showToast({text: String}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white
    );
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        key: _screenKey,
        appBar: AppBar(
          title: Text("Create Match"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: <Widget>[
            Text("First Player",
              ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text("Score: "),
                  new Flexible(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    controller: _firstPlayerScoreController,
                  ))
                ],
              ),
            ),
            Container(padding: const EdgeInsets.only(top: 36.0),
              child: Column(children: <Widget>[
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
              )
            ],),),

            Row(
              children: <Widget>[
                Text("Score: "),
                new Flexible(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  controller: _secondPlayerScoreController,
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: RaisedButton(elevation: 15,
                textColor: Colors.white,
                color: Colors.blueAccent,
                onPressed: () {

                  if(_firstPlayerScoreController.text.isEmpty && _secondPlayerScoreController.text.isEmpty) {
                    this.showToast(text: 'score should not be empty');
                    return;
                  }

                  var player1Score = 0;
                  var player2Score = 0;

                  try {
                    player1Score = int.parse(_firstPlayerScoreController.text);
                    player2Score = int.parse(_secondPlayerScoreController.text);
                  } catch (e) {
                    showToast(text: 'invalid score');
                    return;
                  }

                  if (player1Score == player2Score) {
                    showToast(text: 'There should be a winner. Draw is not allowed');
                    return;

                  }

                    var match = MatchModel();
                    var player1 = Player();
                    player1.name = _firstPlayer.name;
                    player1.score = player1Score;
                    match.player1 = player1;
                    var player2 = Player();
                    player2.name = _secondPlayer.name;
                    player2.score = player2Score;
                    match.player2 = player2;
                    API.createMatches(match).then((response) {
                      Navigator.pop(context, true);
                    });

                },
                child: Text("Create",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),),
              ),
            )
          ]),
        ));
  }


}
