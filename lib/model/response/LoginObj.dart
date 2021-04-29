import 'UserObj.dart';

class LoginObj {
  UserObj user;
  final String token;
  final bool twoFactorAuth;

  LoginObj({this.user, this.token, this.twoFactorAuth});

  LoginObj.fromJson(Map<String, dynamic> json)
      : user = UserObj.fromJson(json['user']),
        token = json['token'],
        twoFactorAuth = json['twoFactorAuth'];
}
