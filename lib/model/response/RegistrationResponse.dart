import 'package:hagglexproject/model/response/RegisterObj.dart';

class RegistrationResponse {
  RegisterObj register;
  String error;

  RegistrationResponse({this.register, this.error});

  RegistrationResponse.fromJson(Map<String, dynamic> json)
      : register = RegisterObj.fromJson(json['register']),
        error = "";

  RegistrationResponse.withError(String errorValue)
      : register = RegisterObj(),
        error = errorValue;
}
