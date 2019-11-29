import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Player.dart';
import 'package:flutter_picker/flutter_picker.dart';


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
  var _firstPlayer = Player();
  List<Player> players = new List<Player>();

  initState() {
    super.initState();
    _getPlayers();
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
        body: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("First Player"),
                new FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        labelText: 'First player',
                      ),
                      isEmpty: _firstPlayer.name == '',
                      child: new DropdownButtonHideUnderline(
                        child: new DropdownButton(
                          value: _firstPlayer,
                          isDense: true,
                          onChanged: (Player newValue) {
                            setState(() {
                              _firstPlayer = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: players.map((Player value) {
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
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

  void _getPlayers() {
    API.getPlayers().then((players){
      this.players = players;
    });
  }

}