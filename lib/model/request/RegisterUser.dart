class RegisterUser {
  String email;
  String username;
  String password;
  String phonenumber;
  String referralCode;
  String country;
  String currency;

  RegisterUser(
      {this.email,
      this.username,
      this.password,
      this.phonenumber,
      this.referralCode,
      this.country,
      this.currency});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'phonenumber': phonenumber,
      'referralCode': referralCode,
      'country': country,
      'currency': currency
    };
  }
}
