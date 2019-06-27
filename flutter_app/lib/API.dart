import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:match_api_app/MatchModel.dart';

const baseUrl = "https://jsonplaceholder.typicode.com";
const localhostUrl = "http://localhost:5000";

class API {
  static Future getUsers() {
    var url = baseUrl + "/users";
    return http.get(url);
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
}
