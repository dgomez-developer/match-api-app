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
        users = response;
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
          return ListTile(title: Text(users[index].name), trailing: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
//                  API.addChinesePingPongPoint(users[index]);
            },
          ),
            leading: CircleAvatar(backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),),);
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
