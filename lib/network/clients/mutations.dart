class Mutations {
  String registerUser() {
    return """
      mutation register(\$data: CreateUserInput){
        register(data: \$data)
    {
     user 
          {
            email
            emailVerified
            phonenumber
            referralCode
            username
            kycStatus
          }
        token
       }
     }    
     """;
  }

  String loginUser() {
    return """
          mutation login(\$data: LoginInput!){
          login(data: \$data)
          {
          user
              {
                email
                emailVerified
                phonenumber
                referralCode
                username
                kycStatus
              }
          token
          twoFactorAuth
         }
        }
    """;
  }
}
