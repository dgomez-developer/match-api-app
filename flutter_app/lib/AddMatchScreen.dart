import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';

class AddMatchScreen extends StatefulWidget {

  final List<Player> players;

  AddMatchScreen({Key key, @required this.players }): super(key : key);

  @override
  AddMatchScreenState createState() {
    return AddMatchScreenState(players: players);
  }
}

class AddMatchScreenState extends State<AddMatchScreen> {

  final _formKey = GlobalKey<FormState>();
  final _screenKey = GlobalKey<ScaffoldState>();
  final _firstPlayerNameController = TextEditingController();
  final _firstPlayerScoreController = TextEditingController();
  final _secondPlayerNameController = TextEditingController();
  final _secondPlayerScoreController = TextEditingController();
  var _firstPlayer = Player();
  final List<Player> players;

  AddMatchScreenState({@required this.players});

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
          title: Text("User List"),
        ),
        body: Column(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("First Player"),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                      controller: _firstPlayerNameController,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter score";
                        }
                        return null;
                      },
                      controller: _firstPlayerScoreController,
                    ),
                    Text("Second Player"),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter name";
                        }
                        return null;
                      },
                      controller: _secondPlayerNameController,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Enter score";
                        }
                        return null;
                      },
                      controller: _secondPlayerScoreController,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          var match = MatchModel();
                          var player1 = Player();
                          player1.name = _firstPlayerNameController.text;
                          player1.score =
                              int.parse(_firstPlayerScoreController.text);
                          match.player1 = player1;
                          var player2 = Player();
                          player2.name = _secondPlayerNameController.text;
                          player2.score =
                              int.parse(_secondPlayerScoreController.text);
                          match.player2 = player2;

                          API.createMatches(match).then((response) {
                            _screenKey.currentState.showSnackBar(
                                SnackBar(content: Text('Match created')));
                          });
                        }
                      },
                      child: Text("Create"),
                    ),
                  ],
                )),
            DropdownButton(
              hint: Text('Please choose a player'),
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
            )
          ],
        ));
  }

}
