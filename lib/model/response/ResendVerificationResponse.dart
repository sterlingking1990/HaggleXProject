class ResendVerificationResponse {
  bool resendVerificationCode;
  String error;

  ResendVerificationResponse({this.resendVerificationCode, this.error});

  Map<String, dynamic> toJson() {
    return {'resendVerificationCode': resendVerificationCode};
  }

  ResendVerificationResponse.fromJson(Map<String, dynamic> json)
      : resendVerificationCode = json['resendVerificationCode'],
        error = "";

  ResendVerificationResponse.withError(String errorValue)
      : resendVerificationCode = false,
        error = errorValue;
}
