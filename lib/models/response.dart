class Response {
  final bool success;
  final dynamic message;

  Response({this.success, this.message});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      success: json['success'],
      message: json['msg'],
    );
  }
}