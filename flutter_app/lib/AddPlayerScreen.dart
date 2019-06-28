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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Match API"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: pushTakePicture,
        child: Icon(Icons.camera_alt),
      ),
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
