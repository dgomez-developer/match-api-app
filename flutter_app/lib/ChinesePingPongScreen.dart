import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/AddPlayerScreen.dart';
import 'package:match_api_app/User.dart'; // Add this line.

class ChinesePingPongScreen extends StatefulWidget {
  @override
  createState() => _ChinesePingPongScreenState();
}

class _ChinesePingPongScreenState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Row(
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
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pushCreateUser,
        child: Icon(Icons.add),
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
