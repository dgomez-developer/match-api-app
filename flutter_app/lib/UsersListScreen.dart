import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:match_api_app/API.dart';
import 'package:match_api_app/AddMatchScreen.dart';
import 'package:match_api_app/User.dart'; // Add this line.

class UsersListScreen extends StatefulWidget {
  @override
  createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State {
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
          return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
              ),
              title: Text(users[index].name)
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pushCreateMatch,
        child: Icon(Icons.add),
      ),
    );
  }

  Route<dynamic> routeToCreateMatch() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return AddMatchScreen();
    });
  }

  void pushCreateMatch() {
    Navigator.of(context).push(routeToCreateMatch());
  }
}
