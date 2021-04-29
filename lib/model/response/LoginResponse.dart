import 'LoginObj.dart';

class LoginResponse {
  final LoginObj login;
  final String error;

  LoginResponse({this.login, this.error});

  LoginResponse.fromJson(Map<String, dynamic> json)
      : login = LoginObj.fromJson(json['login']),
        error = "";

  LoginResponse.withError(String errorValue)
      : login = LoginObj(),
        error = errorValue;
}
