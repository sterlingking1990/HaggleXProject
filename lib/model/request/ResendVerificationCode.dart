class ResendVerificationCode {
  final String email;

  ResendVerificationCode({this.email});

  ResendVerificationCode.fromJson(Map<String, dynamic> json)
      : email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}
