import 'package:hagglexproject/model/response/UserObj.dart';

class RegisterObj {
  UserObj user;
  String token;

  RegisterObj({this.user, this.token});

  RegisterObj.fromJson(Map<String, dynamic> json)
      : user = UserObj.fromJson(json['user']),
        token = json['token'];
}
