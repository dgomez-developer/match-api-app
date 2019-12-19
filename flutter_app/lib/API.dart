import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:match_api_app/Player.dart';
import 'package:match_api_app/User.dart';
import 'package:match_api_app/auth/Secret.dart';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:match_api_app/MatchModel.dart';
import 'package:match_api_app/Policy.dart';

import 'auth/Cognito/sig_v4.dart';


const baseUrl = "https://jsonplaceholder.typicode.com";
const localhostUrl = "http://10.0.2.2:5000";
//const localhostUrl = "http://localhost:5000";

class API {
  static Future<List<User>> getUsers() async {
    var url = localhostUrl + "/players";
    var response = await http.get(url);
    Iterable list = json.decode(response.body);
    return list.map((model) => User.fromJson(model)).toList();
  }

  static Future<List<Player>> getPlayers() async {
    var url = baseUrl + "/players";
    var response = await http.get(url);
    Iterable list = json.decode(response.body);
    return list.map((model) => Player.fromJson(model)).toList();
  }

  static Future<Player> createPlayer(Player player) async {
    var url = baseUrl + "/player";
    //encode Map to JSON
    var body = json.encode(player.toJson());

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    var responsebody = json.decode(response.body);
    return Player.fromJson(responsebody);
  }

  static Future getMatches() {
    var url = localhostUrl + "/matches";
    return http.get(url);
  }
  
  static Future<http.Response> createMatches (MatchModel match) async {
    var url = localhostUrl + "/match";

    //encode Map to JSON
    var body = json.encode(match.toJson());

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  static Future uploadImage(File image) async {

    var secretLoader = SecretLoader(secretPath: "auth/secrets.json");
    var secrets = await secretLoader.load();

    var _accessKeyId = secrets.accessKey;
    var _secretKeyId = secrets.secretKey;
    var _region = secrets.region;
    var _s3Endpoint = secrets.s3Endpoint;

    final stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    final length = await image.length();

    final uri = Uri.parse(_s3Endpoint);
    final req = http.MultipartRequest("POST", uri);
    final multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(image.path));

    final policy = Policy.fromS3PresignedPost('match-api/profile.jpg',
        secrets.s3Bucket, _accessKeyId, 15, length,
        region: _region);
    final key =
    SigV4.calculateSigningKey(_secretKeyId, policy.datetime, _region, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    req.files.add(multipartFile);
    req.fields['key'] = policy.key;
    req.fields['acl'] = 'public-read';
    req.fields['X-Amz-Credential'] = policy.credential;
    req.fields['X-Amz-Algorithm'] = 'AWS4-HMAC-SHA256';
    req.fields['X-Amz-Date'] = policy.datetime;
    req.fields['Policy'] = policy.encode();
    req.fields['X-Amz-Signature'] = signature;

    try {
      final res = await req.send();
      await for (var value in res.stream.transform(utf8.decoder)) {
        print(value);
      }
    } catch (e) {
      print(e.toString());
    }

  }

  static Future deleteMatch(String id) async {
    var url = localhostUrl + "/match/" + id;
    return http.delete(url);
  }

  static Future addChinesePingPongPoint(Player player) async {
    var url = localhostUrl + "/player/" + player.id;
    var body = json.encode(player);
    return http.put(url,body: body,headers: {"Content-Type": "application/json"});
  }
}
