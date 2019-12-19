class User {
  int id;
  String name;
  String email;

  User(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.email = email;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        email = json['email'];

  Map toJson() {
    return {'id': id, 'name': name, 'email': email};
  }
}

/*class Player {

  Player({this.id, this.name, this.score});

  factory Player.fromJson(Map<String, dynamic> json) {
   return Player(id : json['id'],
    name : json['name'],
    score : json['score']);
  }

  Map toJson() {
    return {'name': name, 'score' : score};
  }
}*/