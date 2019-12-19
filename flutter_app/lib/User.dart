class User {
  int id;
  String name;
  String score;

  User(int id, String name, String email) {
    this.id = id;
    this.name = name;
    this.score = email;
  }

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        score = json['score'];

  Map toJson() {
    return {'id': id, 'name': name, 'score': score};
  }
}