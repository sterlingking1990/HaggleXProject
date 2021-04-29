class UserObj {
  String email;
  bool emailVerified;
  String phonenumber;
  String referralCode;
  String userName;
  String kycStatus;

  UserObj(
      {this.email,
      this.emailVerified,
      this.phonenumber,
      this.referralCode,
      this.userName,
      this.kycStatus});

  UserObj.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        emailVerified = json['emailVerified'],
        phonenumber = json['phonenumber'],
        referralCode = json['referralCode'],
        userName = json['userName'],
        kycStatus = json['kycStatus'];
}
