class Queries {
  String resendVerificationCode() {
    return """
    query resendVerificationCode(\$data: EmailInput){
          resendVerificationCode(data: \$data)
    }
    """;
  }

  String getUser(String userId) {
    return """
    query getUser(\$data: GetUserInput){
          getUser(data: \$data)
    }{
      _id
      email
      emailVerified
      phonenumber
      referralCode
      userName
      kycStatus
      }
    """;
  }
}
