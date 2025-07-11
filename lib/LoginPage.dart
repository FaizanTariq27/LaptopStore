import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopstore/HomePage.dart';
import 'package:laptopstore/SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigate to home page after successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      print('Failed with error code: ${e.code}');
      print(e.message);
      // Show an error dialog or message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void _goToSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.indigo[800],
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true, // Align title to the center
        ),
      ),
      backgroundColor: Colors.white, // Set background color of the Scaffold to white
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/loginimg.jpg',
                  height: 200,
                ),
                SizedBox(height: 20.0),
                RichText(
                  text: TextSpan(
                    text: 'Welcome back ',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '\n\nPlease login with your existing account',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ), // Set text color to white
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[800], // Set background color to blue
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
                SizedBox(height: 8.0), // Add some spacing
                TextButton(
                  onPressed: _goToSignupPage,
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(color: Colors.blue), // Set color for the text
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
