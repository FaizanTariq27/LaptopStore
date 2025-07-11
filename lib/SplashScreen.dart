import 'package:flutter/material.dart';
import 'dart:async';
import 'package:laptopstore/WelcomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Trigger the fade-in animation
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Navigate to WelcomePage after 1 second
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => WelcomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff121660), Color(0xff0171df)],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,      // used for fade animation
            duration: Duration(seconds: 1),
            child: Image.asset('assets/images/LaptopStoreLogo.png'),
          ),
        ),
      ),
    );
  }
}