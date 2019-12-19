import 'package:flutter/material.dart';

import 'UserProfile.dart';

class ProfileScreen extends StatefulWidget {
  UserProfile profile;

  ProfileScreen({Key key, @required this.profile}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState(profile: profile);
  }
}

class _ProfileState extends State<ProfileScreen> {
  UserProfile profile;

  _ProfileState({@required this.profile}) {}

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
            child: Column(children: <Widget>[
              CircleAvatar(backgroundImage: NetworkImage(profile.imageUrl)),
              Column(children: <Widget>[
                Text(profile.name),
                Text(profile.email),
              ]),
              Column(
                children: <Widget>[
//                  Text(profile.googleToken),
//                  Text(profile.cognitoAccessId),
//                  Text(profile.cognitoAccessKey),
//                  Text(profile.cognitoSessionToken)
                ],
              )
            ])));
  }
}
