class User{
  final String user;
  double value;
  final String jwt;

 User({this.user, this.value, this.jwt});

 factory User.fromMap(Map<String, dynamic> json,String jwt) {
    return User(
      user: json['user'],
      value: double.parse(json['value']),
      jwt: jwt,
    );
  }

  void updateFromMap(Map<String, dynamic> json){
    value = double.parse(json['value']);
  }
}