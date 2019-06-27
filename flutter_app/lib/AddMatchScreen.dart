import 'package:flutter/material.dart';

class AddMatchScreen extends StatefulWidget {
  @override
  AddMatchScreenState createState() {
    return AddMatchScreenState();
  }
}

class AddMatchScreenState extends State<AddMatchScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
                Text("Second Player"),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter second player name";
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(context)
                          .showSnackBar(
                          SnackBar(content: Text('Creating Match')));
                      // TODO: Request create Match
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