import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  AddMatchScreenState createState() {
    return AddMatchScreenState();
  }
}

class AddMatchScreenState extends State<AddMatchScreen> {

  final _formKey = GlobalKey<FormState>();
  final _screenKey = GlobalKey<ScaffoldState>();
  final _firstPlayerNameController = TextEditingController();
  final _firstPlayerScoreController = TextEditingController();
  final _secondPlayerNameController = TextEditingController();
  final _secondPlayerScoreController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _screenKey,
        appBar: AppBar(
          title: Text("User List"),
        ),
        body: Form(
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
                      player1.score = int.parse(_firstPlayerScoreController.text);
                      match.player1 = player1;
                      var player2 = Player();
                      player2.name = _secondPlayerNameController.text;
                      player2.score = int.parse(_secondPlayerScoreController.text);
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
            )
        )
    );
  }
}