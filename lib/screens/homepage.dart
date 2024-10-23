import 'package:flutter/material.dart';
import 'package:untitled/screens/trackingpage.dart';

import 'accountpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _SchoolHomePageState createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Define the icons for the left, right, and center buttons
  IconData _leftIcon = Icons.location_pin;
  IconData _rightIcon = Icons.person;
  IconData _centerIcon = Icons.home;

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
          MaterialPageRoute(builder: (context) => TrackPage()),
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
          MaterialPageRoute(builder: (context) => HomePage()),
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

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Current location',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              'Mit Gate 2, Manipal, Udupi',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image banner
            Container(
              margin: EdgeInsets.all(16),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/8/82/2009-0617-Ontonagon-school.jpg'), // replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),

            // School name and address
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: .0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Manipal International School',
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Manipal Dr, Madhav Nagar, Manipal, Karnataka',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )),

            SizedBox(height: 20),

            // Stats section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard('RUNNING BUSES', '02'),
                _buildStatCard('STUDENTS ENROLLED', '100'),
              ],
            ),
            SizedBox(height: 20),

            // Announcements
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Announcements',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'see all announcements',
                      style: TextStyle(color: Colors.purpleAccent),
                    ),
                  ),
                ],
              ),
            ),

            // Announcement cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildAnnouncementCard(
                      'Attention !!',
                      'Bus services will not be available on 28/10/24 because of driver union’s strike.',
                      Colors.red),
                  const SizedBox(height: 10),
                  _buildAnnouncementCard(
                      'Attention!!',
                      'School will be celebrating 5 years of completion of bus services',
                      Colors.green),
                ],
              ),
            ),

            // 1. Profile Container
            Padding(
              padding: const EdgeInsets.only(
                  top: 35.0, left: 16, right: 16, bottom: 16),
              child: buildProfileContainer(),
            ),
            SizedBox(height: 1),

            // 2. Bus Information Container
            Padding(
              padding: const EdgeInsets.only(
                  top: 0.0, bottom: 16, left: 16, right: 16),
              child: buildBusInfoContainer(),
            ),
            SizedBox(height: 20),

            // 3. Route Progress Container
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildRouteProgressContainer(),
            ),
            SizedBox(height: 20),

            // 4. Track Live Button Container
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildTrackLiveButtonContainer(),
            ),

// recents summary
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Trip Summary",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildOverallCard(),
                      SizedBox(width: 10),
                      buildAttendanceCard(),
                    ],
                  ),
                  SizedBox(height: 20),
                  buildTimeCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//recent summary widgets//

  Widget buildOverallCard() {
    return Expanded(
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.brown[800],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow,
                    child: Text(
                      "09",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Stops",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• Pick Up Time : 9:00 Am",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "• Drop Off Time : 10:15 Am",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "• Bus Contact : 9064499784",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  "• Driver’s Name : Ahmed Shah",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Lost & Found",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAttendanceCard() {
    return Expanded(
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.brown[800],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Date & Attendance",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "20/10/24",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Attendance : 35/50",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTimeCard() {
    return Container(
      height: 100,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown[800],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total Time Taken",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "1 Hr : 10 Mins",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

//recent summary widgets//

  //methods for different cards student bus etc

  // 1. Profile Container
  Widget buildProfileContainer() {
    return Container(
      height: 189,
      padding: EdgeInsets.only(left: 13, right: 16, bottom: 10, top: 9),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.32),
            spreadRadius: 5,
            blurRadius: 20,
            offset: Offset(0, 3), // changes position of shadow
          )
        ],
        image: DecorationImage(
            image: AssetImage("assets/images/bgg1.png"), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40,
                backgroundImage: AssetImage(
                    'assets/images/stuimage.png'), // Placeholder for profile image
              ),
              SizedBox(width: 26),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ridhwan Vp Shameem',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Age:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " 15 years",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                      SizedBox(
                        width: 15,
                      ),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Class:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " VIII B",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/img1.png"),
                        fit: BoxFit.fill)),
              ),
              SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Bus No:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " DL1024BC",
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ])),
                    SizedBox(height: 5),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Boarding:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " 9:00 am",
                          style: TextStyle(fontWeight: FontWeight.normal)),
                      TextSpan(
                          text: " \nTime",
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ])),
                  ],
                ),
              ),
              SizedBox(width: 25),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "Status:",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: "\nOn Board",
                      style: TextStyle(fontWeight: FontWeight.normal))
                ])),
              ),
            ],
          )
        ],
      ),
    );
  }

  // 2. Bus Information Container
  Widget buildBusInfoContainer() {
    return Container(
        height: 205,
        padding: EdgeInsets.only(left: 8, right: 16, bottom: 10, top: 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.32),
              spreadRadius: 5,
              blurRadius: 20,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          image: DecorationImage(
              image: AssetImage("assets/images/bggg2.png"), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(children: [
          Container(
            height: 150,
            width: 120,
            padding: EdgeInsets.only(left: 13, right: 16, bottom: 10, top: 9),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bus1.png"),
                  fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          SizedBox(width: 8),
          const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Driver’s Name :",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: " \nAhmed Shah",
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ])),
                    SizedBox(height: 4),
                    Text.rich(TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Conductor’s Name:",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "\nSachi Parsekar",
                          style: TextStyle(fontWeight: FontWeight.normal))
                    ])),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Bus No :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \nDL1024BC",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                      SizedBox(height: 5),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Boarding Time :",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n9:00 Am ",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                    ],
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Status : ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \nRunning",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                      SizedBox(height: 5),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Contact No.:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: " \n906449457 ",
                            style: TextStyle(fontWeight: FontWeight.normal))
                      ])),
                    ],
                  ),
                ],
              )
            ],
          )
        ]));
  }

  // 3. Route Progress Container
  Widget buildRouteProgressContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Route Progress',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRouteStop(Icons.location_on, 'A', Colors.green),
            buildRouteStop(Icons.location_on, 'B', Colors.yellow),
            buildRouteStop(Icons.location_on, 'C', Colors.red),
            buildRouteStop(Icons.location_on, 'D', Colors.grey),
            buildRouteStop(Icons.location_on, 'E', Colors.grey),
          ],
        ),
      ],
    );
  }

  Widget buildRouteStop(IconData icon, String stopLabel, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 5),
        Text(stopLabel),
      ],
    );
  }

  // 4. Track Live Button Container
  Widget buildTrackLiveButtonContainer() {
    return Container(
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFf0a500),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: Text(
          'TRACK LIVE',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Helper method to build stat cards
Widget _buildStatCard(String title, String value) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 4,
    child: Container(
      width: 170,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Times New roman")),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

// Helper method to build announcement cards
Widget _buildAnnouncementCard(String attention, String message, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withOpacity(0.1),
      border: Border(left: BorderSide(color: color, width: 5)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(attention,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(message),
      ],
    ),
  );
}
