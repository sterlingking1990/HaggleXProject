class GetUser {
  final String userId;

  GetUser({this.userId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
    };
  }
}
