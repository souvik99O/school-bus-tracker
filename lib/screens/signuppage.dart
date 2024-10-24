import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart'; // Realtime Database package
import 'package:untitled/screens/conductorpage.dart';
import 'package:untitled/screens/homepage.dart';
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
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController busNumberPlateController = TextEditingController();

  // Dropdown values for schools and routes
  String? selectedSchool;
  String? selectedRoute;

  List<String> schools = [];
  List<String> routes = [];

  @override
  void initState() {
    super.initState();
    fetchSchools();
  }

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    nameController.dispose();
    phoneController.dispose();
    childNameController.dispose();
    rollNumberController.dispose();
    busNumberPlateController.dispose();
    super.dispose();
  }

  // Fetch schools from Realtime Database
  Future<void> fetchSchools() async {
    try {
      DatabaseReference schoolsRef = FirebaseDatabase.instance.ref().child('schools');
      DataSnapshot snapshot = await schoolsRef.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> schoolData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          schools = schoolData.keys.toList().cast<String>();
        });
      }
    } catch (e) {
      print('Error fetching schools: $e');
    }
  }

  // Fetch routes based on the selected school
  Future<void> fetchRoutes(String selectedSchool) async {
    try {
      DatabaseReference routesRef = FirebaseDatabase.instance.ref().child('schools/$selectedSchool/routes');
      DataSnapshot snapshot = await routesRef.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> routeData = snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          routes = routeData.keys.toList().cast<String>();
        });
      }
    } catch (e) {
      print('Error fetching routes: $e');
    }
  }

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
                        'assets/images/bus.png',
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

                    // Dropdown for selecting school
                    DropdownButtonFormField<String>(
                      value: selectedSchool,
                      items: schools.map((String school) {
                        return DropdownMenuItem<String>(
                          value: school,
                          child: Text(school),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedSchool = value;
                            fetchRoutes(value); // Fetch routes based on selected school
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Select School',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
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

                      // Dropdown for selecting route
                      DropdownButtonFormField<String>(
                        value: selectedRoute,
                        items: routes.map((String route) {
                          return DropdownMenuItem<String>(
                            value: route,
                            child: Text(route),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              selectedRoute = value;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Select Route',
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
                          if (isParentSelected) {
                            // Navigate to HomePage for Parent
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          } else {
                            // Navigate to ConductorPage for School
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ConductorPage()),
                            );
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Log in',
                              style: TextStyle(color: Colors.yellow[800], fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginPage()),
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
