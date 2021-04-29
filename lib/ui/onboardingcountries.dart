import 'package:flutter/material.dart';

void main() => runApp(OnBoardingCountry());

class OnBoardingCountry extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: OnBoardingCountryApp()),
      );
}

class OnBoardingCountryApp extends StatefulWidget {
  @override
  OnBoardingCountryAppState createState() => OnBoardingCountryAppState();
}

class OnBoardingCountryAppState extends State<OnBoardingCountryApp> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: Container(
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
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: ShowSearchBar("Search for country")),
              Divider(
                thickness: 2,
                indent: 10,
                color: Color(0x58478299),
                endIndent: 10,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(
                            "https://www.countryflags.com/wp-content/uploads/nigeria-flag-png-large.png",
                            fit: BoxFit.cover),
                        title: Text(
                          "(+234) Nigeria",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                  itemCount: 20,
                ),
              )
            ],
          ),
        ),
      ));
}

Widget ShowSearchBar(String hintText) => Stack(
      alignment: AlignmentDirectional.centerEnd,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0x58478299),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.white)),
              controller: TextEditingController(),
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.search,
              color: Colors.white,
            ))
      ],
    );
