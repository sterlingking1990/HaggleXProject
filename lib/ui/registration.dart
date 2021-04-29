import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hagglexproject/appstate/registeruserstate.dart';
import 'package:hagglexproject/model/request/RegisterUser.dart';
import 'package:hagglexproject/model/response/RegistrationResponse.dart';
import 'package:hagglexproject/network/clients/resend_verification_model.dart';
import 'package:hagglexproject/ui/verifyaccountpage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  Hive.init(appDocPath);

  Hive.registerAdapter(ResendVerificationModelAdapter());
  runApp(RegisterApp());
}

class RegisterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: RegisterForm(),
        ),
      );
}

class RegisterForm extends StatefulWidget {
  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  bool isRegistrationProcessBegan;

  TextEditingController emailAddressInputController;
  TextEditingController passwordInputController;
  TextEditingController usernameInputController;
  TextEditingController phoneNumberInputController;
  TextEditingController referralCodeInputController;

  @override
  void initState() {
    emailAddressInputController = TextEditingController();
    usernameInputController = TextEditingController();
    passwordInputController = TextEditingController();
    phoneNumberInputController = TextEditingController();
    referralCodeInputController = TextEditingController();

    isRegistrationProcessBegan = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 800,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFF2E1963),
                Color(0xFF3B2671),
                Color(0xFF2E1963),
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.3, 0.4],
              tileMode: TileMode.clamp,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 30),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    )),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40, left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Create a new account",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: TextField(
                                onTap: () => enableRegistration(),
                                controller: emailAddressInputController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: TextField(
                                onTap: () => enableRegistration(),
                                controller: passwordInputController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Password (Min 8 characters)",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: TextField(
                                onTap: () => enableRegistration(),
                                controller: usernameInputController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Create a Username",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            SizedBox(height: 30),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 9, right: 5),
                                  child: InkWell(
                                    onTap: () => loadCountries(),
                                    child: Container(
                                      color: Color(0xE8E8E8ff),
                                      width: 90,
                                      height: 40,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 7),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 10,
                                                height: 15,
                                                color: Colors.green),
                                            Container(
                                                width: 10,
                                                height: 15,
                                                color: Colors.white),
                                            Container(
                                                width: 10,
                                                height: 15,
                                                color: Colors.green),
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 2, top: 1),
                                                    child: Text("(+234)")))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: TextField(
                                      onTap: () => enableRegistration(),
                                      controller: phoneNumberInputController,
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Enter Phone Number",
                                          hintStyle:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: TextField(
                                onTap: () => enableRegistration(),
                                controller: referralCodeInputController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Referral code(optional)",
                                    hintStyle: TextStyle(color: Colors.grey)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: Text(
                                "By signing up, you agree to HaggleX terms and privacy policy",
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            !isRegistrationProcessBegan
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(top: 30, right: 20),
                                    child: Container(
                                      margin: EdgeInsets.all(15),
                                      width: 280,
                                      height: 52,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0x6A4B00BC),
                                            Color(0xFF3B2671),
                                            Color(0xFF3B2671),
                                            Color(0x6A4B00BC),
                                          ],
                                          begin: Alignment.topRight,
                                          end: Alignment.topLeft,
                                          stops: [0.3, 0.5, 0.9, 1],
                                          tileMode: TileMode.clamp,
                                        ),
                                      ),
                                      child: FlatButton(
                                        child: Text(
                                          'Sign Up',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: activateRegistration,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    child: handleRegistrationAndLoginRouting())
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void loadCountries() {}

  void activateRegistration() {
    setState(() {
      if (isRegistrationProcessBegan == false) {
        isRegistrationProcessBegan = true;
      } else {
        isRegistrationProcessBegan = false;
      }
    });
  }

  void enableRegistration() {
    setState(() {
      if (isRegistrationProcessBegan == true) {
        isRegistrationProcessBegan = false;
      }
    });
  }

  handleRegistrationAndLoginRouting() {
    registerUserState.registerUser(RegisterUser(
        email: emailAddressInputController.text,
        username: usernameInputController.text,
        password: passwordInputController.text,
        phonenumber: phoneNumberInputController.text,
        referralCode: referralCodeInputController.text == ""
            ? ""
            : referralCodeInputController.text,
        country: "Nigeria",
        currency: "NGN"));

    return StreamBuilder<RegistrationResponse>(
        stream: registerUserState.registrationStateObservable,
        builder:
            // ignore: missing_return
            (context, AsyncSnapshot<RegistrationResponse> response) {
          if (response.hasData) {
            if (response.data.error != "") {
              return _buildErrorWidget(response.data.error.toString());
            } else {
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  isRegistrationProcessBegan = false;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyAccountPage()));
                // ignore: unrelated_type_equality_checks
              });
              // show the Snackba
            }
          }
          return buildLoadingWidget();
        });
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Error occured: $error",
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    ));
  }

  Widget buildLoadingWidget() => Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "completing registration...",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            CircularProgressIndicator()
          ],
        ),
      );
}
