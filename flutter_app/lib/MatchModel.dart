import 'package:match_api_app/Player.dart';

class MatchModel {

  String id;
  Player player1;
  Player player2;

  MatchModel({this.id, this.player1, this.player2});

  factory MatchModel.fromJson(Map<String, dynamic> json){
   return MatchModel(id : json['id'] as String,
    player1 : Player.fromJson(json['player1']),
    player2 : Player.fromJson(json['player2']));
  }

  Map toJson() {
    return {'player1': player1.toJson(), 'player2': player2.toJson()};
  }
}