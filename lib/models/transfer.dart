class Transfer{
  final String user;
  final double value;
  final String date;
  final String type;

  Transfer({this.user,this.value,this.date,this.type});

  factory Transfer.fromMap(Map<String, dynamic> json) {
    return Transfer(
      user: json['user'],
      value: double.parse(json['value'].toString()),
      date: json['date'],
      type: json['type'],
    );
  }
}