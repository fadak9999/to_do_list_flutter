import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list_flutter/login/login.dart';

class introduction extends StatefulWidget {
  const introduction({super.key});

  @override
  State<introduction> createState() => _introductionState();
}

class _introductionState extends State<introduction> {
  ////++++++++++++++++++++++++++++++

//1
  savepref2(String intt) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("int", intt);
  }

//2
  getpref2() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var loginn = preferences.getString("int");
    if (loginn != null) {
      Get.to(login());
    }
  }

  //3
  @override
  void initState() {
    getpref2();
    super.initState();
  }

  ///++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        scrollPhysics: BouncingScrollPhysics(),
        pages: [
          PageViewModel(
            titleWidget: Text(
              "You Welcome in : ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            body: "To Do List",
            image: Image.asset(
              "assets/one.png",
              height: 400,
              width: 400,
            ),
          ),
          //
          PageViewModel(
            titleWidget: Text(
              " 'To Do List' app allows you to : ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            body: "Record your tasks",
            image: Image.asset(
              "assets/two.png",
              height: 400,
              width: 400,
            ),
          ),
          //
          PageViewModel(
            titleWidget: Text(
              "Thank You",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            body: "We hope you benefit from it",
            image: Image.asset(
              "assets/three.png",
              height: 400,
              width: 400,
            ),
          ),
          /////
        ],
        onDone: () async {
          //+++++++++++++++++++++++++++++

          await savepref2("int");

          //++++++++++++++++++++++++++++++++++++++++++++++++++
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => login(),
              ));
        },
        onSkip: () {},
        showBackButton: false,
        skip: Text(
          "Skip",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 27, 113, 200)),
        ),
//
        next: Icon(
          Icons.arrow_forward,
          color: Color.fromARGB(255, 27, 113, 200),
        ),
        done: Text(
          "Done",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(255, 27, 113, 200)),
        ),
        dotsDecorator: DotsDecorator(
            size: Size.square(10.0),
            activeSize: Size(20.0, 10.0),
            color: Colors.black26,
            activeColor: Color.fromARGB(255, 27, 113, 200),
            spacing: EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            )),
      ),
    );
  }
}
