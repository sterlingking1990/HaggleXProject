import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hagglexproject/appstate/loginstate.dart';
import 'package:hagglexproject/model/request/LoginUser.dart';
import 'package:hagglexproject/model/response/LoginResponse.dart';
import 'package:hagglexproject/ui/dashboard.dart';
import 'package:hagglexproject/ui/registration.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController emailInput;
  TextEditingController passwordInput;
  LoginState loginState;
  bool isLoggingInButtonClicked;

  @override
  void initState() {
    isLoggingInButtonClicked = false;
    emailInput = TextEditingController();
    passwordInput = TextEditingController();
    loginState = LoginState();
    super.initState();

    Future.delayed(Duration.zero, handleLoginAndDashboardRouting);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailInput.clear();
    passwordInput.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: 800,
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
            child: Padding(
              padding: EdgeInsets.only(top: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Welcome!",
                          style: TextStyle(fontSize: 35, color: Colors.white))),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onTap: () => resetLoginButton(),
                        controller: emailInput,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: Colors.white)),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onTap: () => resetLoginButton(),
                        controller: passwordInput,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: "Password (Min 8 characters)",
                            hintStyle: TextStyle(color: Colors.white)),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    child: Padding(
                        padding: EdgeInsets.only(left: 220, right: 10),
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  !isLoggingInButtonClicked
                      ? Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 52,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFFC17500)),
                            child: FlatButton(
                              child: Text(
                                'LOG IN',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: handleLogin,
                            ),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: handleLoginAndDashboardRouting()),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterForm())),
                    child: Padding(
                        padding: EdgeInsets.only(left: 120),
                        child: Text(
                          "New User? Create a new account",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  void handleLogin() {
    setState(() {
      if (isLoggingInButtonClicked == false) {
        isLoggingInButtonClicked = true;
      } else {
        isLoggingInButtonClicked = false;
      }
    });
  }

  void resetLoginButton() {
    setState(() {
      if (isLoggingInButtonClicked == true) {
        isLoggingInButtonClicked = false;
        emailInput.text = "";
        passwordInput.text = "";
      }
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
            style: TextStyle(color: Colors.white),
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
                "Logging you in...",
                style: TextStyle(color: Colors.white),
              ),
            ),
            CircularProgressIndicator()
          ],
        ),
      );

  Widget handleLoginAndDashboardRouting() {
    loginState.loginUser(
        LoginInput(input: emailInput.text, password: passwordInput.text));
    return StreamBuilder<LoginResponse>(
        stream: loginState.loginStateObservable,
        builder:
            // ignore: missing_return
            (context, AsyncSnapshot<LoginResponse> response) {
          if (response.hasData) {
            if (response.data.error != "") {
              return _buildErrorWidget(response.data.error.toString());
            } else {
              Future.delayed(const Duration(milliseconds: 100), () {
                setState(() {
                  isLoggingInButtonClicked = false;
                  emailInput.text = "";
                  passwordInput.text = "";
                });
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
                // ignore: unrelated_type_equality_checks
              });
            }
            // show the Snackba
          }
          return buildLoadingWidget();
        });
  }
}
