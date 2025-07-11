import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopstore/HomePage.dart';
import 'package:laptopstore/LoginPage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Update the user's display name
      await user?.updateDisplayName(_nameController.text.trim());

      // Reload the user to make sure the display name is updated
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;

      // Store user information in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'username': _nameController.text.trim(),
        'email': _emailController.text.trim(),
      });

      // Navigate to home page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle signup errors
      print('Failed with error code: ${e.code}');
      print(e.message);

      // Show an error dialog or message to the user
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Signup Failed'),
            content: Text(e.message ?? 'Failed to create account. Please try again.'),
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

  void _goToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          title: Text(
            'Signup',
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5.0),
                Image.asset(
                  'assets/images/loginimg.jpg',
                  height: 200,
                ),
                SizedBox(height: 5.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                  child: RichText(
                    text: TextSpan(
                      text: 'Welcome ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\n\nPlease enter your information',
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
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0), // Add horizontal padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Reduced border radius
                          ),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _signup,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[800], // Set background color to blue
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                ),
                TextButton(
                  onPressed: _goToLoginPage,
                  child: Text(
                    'Already have an account? Log In',
                    style: TextStyle(color: Colors.indigo[800]),
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
