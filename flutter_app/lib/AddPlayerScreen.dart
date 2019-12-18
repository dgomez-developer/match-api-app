import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:match_api_app/TakePictureScreen.dart';

class AddPlayerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddPlayerScreenState();
  }
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {

  var _userNameTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  child: TextField(showCursor: true,
                                   autofocus: true,
                                   keyboardType: TextInputType.number,
                                   maxLines: 1)
              )
            ],
          )
        ]
        ),

      ),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.green.shade800,
        onPressed: pushTakePicture,
        child: Icon(Icons.camera_alt),
      ),
    );
  }

  void execute() {

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
