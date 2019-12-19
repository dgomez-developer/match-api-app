import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/AddPlayerScreen.dart';
import 'package:match_api_app/User.dart'; // Add this line.
import 'package:match_api_app/Player.dart';

class ChinesePingPongScreen extends StatefulWidget {
  @override
  createState() => _ChinesePingPongScreenState();
}

class _ChinesePingPongScreenState extends State {
  var players = new List<Player>();

  /*_getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        players = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }*/

  Future<Null> _getPlayers() {
    return API.getPlayers().then((response) {
      setState(() {
        players = response;
      });
    });
  }

  initState() {
    super.initState();
    _getPlayers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(players[index].name), subtitle: Text(players[index].score.toString() + "  points"),


            trailing: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.remove), onPressed: () {API.addChinesePingPongPoint(players[index]);},),
                  IconButton(icon: Icon(Icons.add), onPressed: () {API.addChinesePingPongPoint(players[index]);},)
                ],
                mainAxisSize: MainAxisSize.min),

            leading: CircleAvatar(backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),),
          );
         /* return Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
              ),
              Text(users[index].name),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
//                  API.addChinesePingPongPoint(users[index]);
                },
              )
              ],
          );*/
        },
      ),
    );
  }

  Route<dynamic> routeToCreatePlayer() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return AddPlayerScreen();
    });
  }

  void pushCreateUser() {
    Navigator.of(context).push(routeToCreatePlayer());
  }
}
