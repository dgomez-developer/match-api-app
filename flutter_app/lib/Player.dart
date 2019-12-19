class Player {

  String id;
  String name;
  int score;

  Player(String id, String name, int score){
    this.id = id;
    this.name = name;
    this.score = score;
  }

  factory Player.fromJson(Map<String, dynamic> json) {
   return new Player(json['id'],
       json['name'],
       json['score']);
  }

  Map toJson() {
    return {'name': name, 'score' : score};
  }
}