import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hagglexproject/network/clients/resend_verification_model.dart';
import 'package:hagglexproject/ui/login.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  Hive.init(appDocPath);

  Hive.registerAdapter(ResendVerificationModelAdapter());
  runApp(HaggleX());
}

class HaggleX extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: HaggleApp()),
      );
}

class HaggleApp extends StatefulWidget {
  @override
  HaggleAppState createState() => HaggleAppState();
}

class HaggleAppState extends State<HaggleApp> {
  @override
  void initState() {
    // TODO: implement setState
    new Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/hagglexlogo.png',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "HaggleX",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ))
            ],
          )));
}
