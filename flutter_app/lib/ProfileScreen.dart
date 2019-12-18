import 'package:flutter/material.dart';

import 'UserProfile.dart';

class ProfileScreen extends StatefulWidget {

  UserProfile profile;

  ProfileScreen({Key key, @required this.profile}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileScreen> {

  UserProfile profile;

  _ProfileState({@required this.profile}){}

  @override
  Widget build(BuildContext context) {
    return createProfile();
  }

  Scaffold createProfile() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child:
            Row(
              children: <Widget>[
                Column(children: <Widget>[
                  CircleAvatar(backgroundImage: NetworkImage(profile.imageUrl)),
                  Row(
                      children: <Widget>[
                        Text(profile.name),
                        Text(profile.email),

                      ]
                  )
                ]
                ),
                Row(
                  children: <Widget>[
                    Text(profile.googleToken),

                  ],
                )
              ],
            )
        ));
  }
}
