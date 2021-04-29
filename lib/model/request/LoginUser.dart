class LoginInput {
  final String input;
  final String password;

  LoginInput({this.input, this.password});

  Map<String, dynamic> toJson() {
    return {'input': input, 'password': password};
  }
}
