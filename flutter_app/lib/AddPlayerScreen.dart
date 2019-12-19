import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:match_api_app/Player.dart';
import 'package:match_api_app/TakePictureScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:match_api_app/API.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {

  var _userNameTextField = TextEditingController();
  var _emailTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Player"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text("user name: "),
              new Flexible(
                  child: TextField(showCursor: true, autofocus: true, controller: _userNameTextField)
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text("email:          "),
              new Flexible(
                  child: TextField(showCursor: true, autofocus: false, controller: _emailTextField)
              )
            ],
          ),
        RaisedButton(elevation: 15,
            textColor: Colors.white,
            color: Colors.green.shade800,
            onPressed: () {
                 _execute();

            }, child: Text("Create",
                           style: TextStyle(fontSize: 14.0,
                                            fontWeight: FontWeight.bold)
                          )
        )
        ]
        ),
      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.amber,
        onPressed: pushTakePicture,
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void _execute() {
    if(_userNameTextField.text.isEmpty || _emailTextField.text.isEmpty) {
      this._showToast(text: 'all fields are mandatory');
      var result = API.createPlayer(new Player("", _userNameTextField.text.trim(), 0));
      _showToast(text : "User Created");
      return;
    }

  }

  void _showToast({text: String}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white
    );
  }

  Future<Route<dynamic>> routeToCamera() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();
    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;
    return MaterialPageRoute(builder: (BuildContext context) {
      return TakePictureScreen(
        camera: firstCamera
      );
    });
  }

  void pushTakePicture() {
    routeToCamera().then((route) {
      setState(() {
        Navigator.of(context).push(route);
      });
    });
  }
}
