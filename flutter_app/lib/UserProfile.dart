class UserProfile {

  String name;
  String email;
  String imageUrl;
  String googleToken;
  String cognitoSessionToken;
  String cognitoAccessKey;
  String cognitoAccessId;

  UserProfile(String name,
      String email,
      String imageUrl,
      String googleToken,
      String cognitoSessionToken,
      String cognitoAccessKey,
      String cognitoAccessId) {
    this.name = name;
    this.email = email;
    this.imageUrl = imageUrl;
    this.googleToken = googleToken;
    this.cognitoSessionToken = cognitoSessionToken;
    this.cognitoAccessKey = cognitoAccessKey;
    this.cognitoAccessId = cognitoAccessId;
  }


}