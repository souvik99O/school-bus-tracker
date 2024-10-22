// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'homepage.dart'; // Import the SchoolHomePage component
import 'signuppage.dart'; // Import the SignUp component

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, // Set the background color to yellow
      body: SafeArea(
        child: SingleChildScrollView( // Make the Column scrollable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row for the back arrow and sign-in text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Define action on back arrow press
                      },
                      color: Colors.black,
                    ),
                    SizedBox(width: 8), // Space between the arrow and the text
                    Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24, // Bigger font size
                        fontWeight: FontWeight.bold, // Bold text
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0), // Margin on left and right
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the inner layer color to white
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3), // Light shadow
                      blurRadius: 10,
                      offset: Offset(0, 4), // Slightly downwards shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Skoolyatra,',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Hello there, sign in to continue',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: Image.asset(
                        'images/bus.png', // Image of the school bus (Ensure the image is in assets folder)
                        height: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[600], // Background color of the button
                          foregroundColor: Colors.white, // Text color
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () 
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                // Navigate to Sign Up page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(), // Ensure SignUp is defined in signup.dart
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
