import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SchoolHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SchoolHomePage extends StatefulWidget {
  @override
  _SchoolHomePageState createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<SchoolHomePage> {
  int _selectedIndex = 0;

  // List of widgets to be displayed for each page
  final List<Widget> _pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Location Page')),
    Center(child: Text('Account Page')),
  ];

  // Handling tab navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Displays the current page

      backgroundColor: Color(0xFFF6F6F6),
      bottomNavigationBar: Container(
        // color: Colors.yellow,
        height: 50,
        decoration: BoxDecoration(color: Colors.yellow.shade700, borderRadius: BorderRadius.only(topLeft:Radius.circular(25) ,topRight:Radius.circular(25))),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
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
                image: DecorationImage(
                  image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/8/82/2009-0617-Ontonagon-school.jpg'), // replace with your image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10),

            // School name and address
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: .0),
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
                  Text(
                    'Announcements',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
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
                  SizedBox(height: 10),
                  _buildAnnouncementCard(
                      'Attention!!',
                      'School will be celebrating 5 years of completion of bus services',
                      Colors.green),
                ],
              ),
            ),


            // 1. Profile Container
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildProfileContainer(),
            ),
            SizedBox(height: 20),

            // 2. Bus Information Container
            Padding(
              padding: const EdgeInsets.all(16.0),
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




          ],
        ),
      ),
    );
  }








  //methods for different cards student bus etc

  // 1. Profile Container
  Widget buildProfileContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFf5c25b),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Placeholder for profile image
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ridhwan Vp Shameem',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Age : 15 years'),
              Text('Class : VIII B'),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Bus Information Container
  Widget buildBusInfoContainer() {
    return Column(
      children: [
        // First Bus Info
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFf0ad00),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset('assets/bus.png', height: 50, width: 50), // Replace with your asset
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bus No: DL1024BC'),
                  Text('Boarding: 9:00 am'),
                  Text('Status: On Board'),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),

        // Second Bus Info (Driver & Conductor details)
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFf0ad00),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Image.asset('assets/driver_bus.png', height: 50, width: 50), // Replace with your asset
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Driver\'s Name: Ahmed Shah'),
                  Text('Conductor\'s Name: Sachi Parsekar'),
                  Text('Bus No: DL1024BC'),
                  Text('Contact: 9064649457'),
                  Text('Status: Running'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
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
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFf0a500),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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

