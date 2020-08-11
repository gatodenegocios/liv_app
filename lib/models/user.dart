class User{
  //final String uid;
  final String user;
  final double value;
  /*final String name;
  final String email;*/
  final String jwt;

 User({this.user, this.value, this.jwt});//,this.name,this.email,this.jwt

 factory User.fromMap(Map<String, dynamic> json,String jwt) {
    return User(
      user: json['user'],
      value: double.parse(json['value']),
      jwt: jwt,
    );
  }
}