import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hagglexproject/appstate/resendverificationstate.dart';
import 'package:hagglexproject/model/request/ResendVerificationCode.dart';
import 'package:hagglexproject/model/response/ResendVerificationResponse.dart';
import 'package:hagglexproject/network/clients/resend_verification_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  Hive.init(appDocPath);

  Hive.registerAdapter(ResendVerificationModelAdapter());
  runApp(VerifyAccountApp());
}

class VerifyAccountApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: VerifyAccountPage()));
  }
}

class VerifyAccountPage extends StatefulWidget {
  @override
  VerifyAccountPageState createState() => VerifyAccountPageState();
}

class VerifyAccountPageState extends State<VerifyAccountPage> {
  bool resendCodeClicked;

  @override
  void initState() {
    resendCodeClicked = false;
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
                    )),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 30),
                  child: Text(
                    "Verify your Account",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.book),
                            SizedBox(height: 30),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: Text(
                                "We just sent a verification code to your email. Please enter the code.",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 30),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintText: "Verification code",
                                    hintStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 30, right: 20),
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
                                      'VERIFY ME',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: Text(
                                "This code will expire in 10mins",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            resendCodeClicked
                                ? Expanded(
                                    child: Container(
                                        height: 20,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: resendCode()),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.only(top: 30, right: 20),
                                    child: InkWell(
                                      onTap: () => triggerResendCode(),
                                      child: Text(
                                        "Resend Code",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ),
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

  void triggerResendCode() {
    setState(() {
      if (resendCodeClicked == false) {
        resendCodeClicked = true;
      } else {
        resendCodeClicked = false;
      }
    });
  }

  void resetResendButton() {
    setState(() {
      if (resendCodeClicked == true) {
        resendCodeClicked = false;
      }
    });
  }

  resendCode() {
    String email = "izundukingsleyemeka@gmail.com";
    resendVerificationState
        .resendVerificationCode(ResendVerificationCode(email: email));

    return StreamBuilder<ResendVerificationResponse>(
        stream:
            resendVerificationState.resendVerificationCodeResponseObservable,
        builder:
            // ignore: missing_return
            (context, AsyncSnapshot<ResendVerificationResponse> response) {
          if (response.data != null) {
            if (response.data.error != "") {
              return _buildErrorWidget(response.data.error.toString());
            }
            print(response.data.resendVerificationCode);
            return _sentCodeResponse();
            // ignore: unrelated_type_equality_checks
          } else if (response.data == null) {
            return _buildErrorWidget(response.error.toString());
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _sentCodeResponse() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Column(children: [
            Text(
              "code sent, please check mail",
              style: TextStyle(color: Colors.black),
            ),
            InkWell(
              onTap: () => resetResendButton(),
              child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text("Try again", style: TextStyle(fontSize: 15))),
            ),
          ]),
        )
      ],
    ));
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
                "sending verification code...",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            CircularProgressIndicator()
          ],
        ),
      );
}
