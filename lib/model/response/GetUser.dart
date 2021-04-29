class GetUserResponse {
  String email;
  bool emailVerified;
  String phonenumber;
  String referralCode;
  String userName;
  String kycStatus;
  String error;

  GetUserResponse(
      {this.emailVerified,
      this.phonenumber,
      this.referralCode,
      this.userName,
      this.kycStatus,
      this.error});

  GetUserResponse.fromJson(Map<String, dynamic> json)
      : emailVerified = json['emailVerified'],
        phonenumber = json['phonenumber'],
        referralCode = json['referralCode'],
        userName = json['userName'],
        kycStatus = json['kycStatus'],
        error = "";

  GetUserResponse.withError(String errorValue)
      : email = "",
        emailVerified = false,
        phonenumber = "",
        referralCode = "",
        userName = "",
        kycStatus = "",
        this.error = errorValue;
}
