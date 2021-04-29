import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(SetUpCompletionApp());

class SetUpCompletionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: SetUpCompletionPage()),
      );
}

class SetUpCompletionPage extends StatefulWidget {
  @override
  SetUpCompletionPageState createState() => SetUpCompletionPageState();
}

class SetUpCompletionPageState extends State<SetUpCompletionPage> {
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
              SizedBox(height: 30),
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 50),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 2,
                          left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.book),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 2, right: 20),
                            child: Text(
                              "Setup Complete",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(top: 2, right: 20),
                            child: Text(
                              "Thank you for setting up your HaggleX account",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          SizedBox(height: 180),
                          Padding(
                              padding: EdgeInsets.only(top: 30, right: 20),
                              child: Container(
                                margin: EdgeInsets.all(15),
                                width: 280,
                                height: 52,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFC17500)),
                                child: FlatButton(
                                  child: Text(
                                    'START EXPLORING',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {},
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ));
}
