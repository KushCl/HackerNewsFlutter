import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hacker_news/pages/HomePage.dart';
import 'package:hacker_news/screens/LoginScreen.dart';


class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => new _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>{

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (BuildContext ctxt ){
      return new  HomePage();
    }));
  }

  void initState(){
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/logo_transparent.png')
      ),
    );
  }

}
