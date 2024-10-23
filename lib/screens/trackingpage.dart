import 'package:flutter/material.dart';
import 'package:untitled/screens/accountpage.dart';
import 'package:untitled/screens/trackingpage.dart';

import 'package:untitled/screens/homepage.dart';

class TrackPage extends StatefulWidget {
  @override
  _SchoolHomePageState createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<TrackPage> {
  int _selectedIndex = 0;

  // Define the icons for the left, right, and center buttons
  IconData _leftIcon = Icons.home;
  IconData _rightIcon = Icons.person;
  IconData _centerIcon = Icons.location_pin;

  // Method to handle swapping of icons and navigate to respective pages
  void _onItemTapped(String position) {
    setState(() {
      if (position == 'left') {
        // Swap the left icon with the center icon and navigate to Location Page
        IconData temp = _centerIcon;
        _centerIcon = _leftIcon;
        _leftIcon = temp;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else if (position == 'right') {
        // Swap the right icon with the center icon and navigate to Account Page
        IconData temp = _centerIcon;
        _centerIcon = _rightIcon;
        _rightIcon = temp;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      } else {
        // Navigate to Home Page when center button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TrackPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        // Your existing body content remains intact here
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          children: [
            // Bottom Navigation Bar Background
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.yellow.shade700,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left Button (dynamically swapping with the center)
                    IconButton(
                      icon: Icon(_leftIcon, size: 30, color: Colors.white),
                      onPressed: () {
                        _onItemTapped(
                            'left'); // Swap left and center icons, show Location page
                      },
                    ),

                    const SizedBox(width: 30), // Space for the elevated button

                    // Right Button (dynamically swapping with the center)
                    IconButton(
                      icon: Icon(_rightIcon, size: 30, color: Colors.white),
                      onPressed: () {
                        _onItemTapped(
                            'right'); // Swap right and center icons, show Account page
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Elevated Center Button
            Positioned(
              top: -30, // To elevate the button above the navigation bar
              left: MediaQuery.of(context).size.width / 2 - 35,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange.shade400,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    _centerIcon, // Show the selected icon in the center
                    size: 40,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _onItemTapped('center'); // Navigate to Home page
                  },
                ),
              ),
            ),
          ],
        ),
        body: Center(child: Text("Track page")));
  }
}
