import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage {

  static final TOKEN_KEY = "token";
  FlutterSecureStorage storage;

  AppStorage() {
    storage = new FlutterSecureStorage();
  }

  storeToken(token) async {
    await storage.write(key: TOKEN_KEY, value: token);
  }

  restoreToken() async {
    return await storage.read(key: TOKEN_KEY);
  }

}