import 'package:flutter/material.dart';
import 'package:laptopstore/LoginPage.dart';
import 'package:laptopstore/SignupPage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121660), // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/welcomepage1.png',
                    height: 200,
                  ),
                  SizedBox(height: 20.0), // Add space between image and text
                  RichText(
                    text: TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Laptop Store',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(
                          text: '\n\nDiscover the perfect laptop for your needs.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text('Login',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xff121660),
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(height: 10.0), // Add space between buttons
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                      child: Text('Sign Up',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color(0xff121660),
                        fontWeight: FontWeight.bold,
                      ),
                      ),

                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
