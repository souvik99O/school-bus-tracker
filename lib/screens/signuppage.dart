// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/loginpage.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isParentSelected = true; // Parent selected by default

  // Controllers for dynamic text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController childNameController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController busNumberPlateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, // Set background color to yellow
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.black,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
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
                      'Hello there, create a new account to track your child seamlessly.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'images/bus.png',
                        height: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Buttons for Parent and School
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isParentSelected = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isParentSelected ? Colors.yellow : Colors.white,
                              foregroundColor: isParentSelected ? Colors.black : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: isParentSelected ? Colors.yellow : Colors.grey,
                                ),
                              ),
                            ),
                            child: Text("Parent"),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isParentSelected = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isParentSelected ? Colors.white : Colors.yellow,
                              foregroundColor: isParentSelected ? Colors.grey : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  color: isParentSelected ? Colors.grey : Colors.yellow,
                                ),
                              ),
                            ),
                            child: Text("School"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Name and Phone Number TextFields
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 20),
                    
                    // Conditional fields for Parent or School
                    if (isParentSelected) ...[
                      // For Parent: Additional fields
                      TextField(
                        controller: childNameController,
                        decoration: InputDecoration(
                          labelText: 'Name of Child',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: routeController,
                        decoration: InputDecoration(
                          labelText: 'Route',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: rollNumberController,
                        decoration: InputDecoration(
                          labelText: 'Roll Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ] else ...[
                      // For School: Bus number plate
                      TextField(
                        controller: busNumberPlateController,
                        decoration: InputDecoration(
                          labelText: 'Bus Number Plate',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                    
                    SizedBox(height: 20),
                    // Terms and Conditions checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (bool? value) {
                            // Add your checkbox action here
                          },
                          activeColor: Colors.yellow,
                        ),
                        Text("By creating an account, you agree to our "),
                        Text(
                          "Terms and Conditions",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Sign up button
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[600],
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () {
                          // Perform sign-up logic here
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Colors.purple,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(), // Ensure SignUp is defined in signup.dart
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
