class Player {

  String id;
  String name;
  int score;

  Player({this.id, this.name, this.score});

  factory Player.fromJson(Map<String, dynamic> json) {
   return Player(id : json['id'],
    name : json['name'],
    score : json['score']);
  }

  Map toJson() {
    return {'name': name};
  }
}