import 'package:flutter/material.dart';
import 'package:untitled/screens/trackingpage.dart';
import 'package:untitled/screens/homepage.dart';

class AccountPage extends StatefulWidget {
  @override
  _SchoolHomePageState createState() => _SchoolHomePageState();
}

class _SchoolHomePageState extends State<AccountPage> {
  int _selectedIndex = 0;

  // Define the icons for the left, right, and center buttons
  IconData _leftIcon = Icons.location_pin;
  IconData _rightIcon = Icons.home;
  IconData _centerIcon = Icons.person;

  String selectedStudent = '';
  String phoneNumber = '1234567890';
  String password = '********';
  bool isPasswordEditable = false;

  List<Map<String, String>> students = [
    {
      'rollNumber': '001',
      'name': 'John Doe',
      'school': 'School A',
      'route': 'Route 1',
      'busNumber': 'Bus 5'
    },
    {
      'rollNumber': '002',
      'name': 'Jane Smith',
      'school': 'School B',
      'route': 'Route 2',
      'busNumber': 'Bus 3'
    },
  ];

  // Text editing controllers for account details
  TextEditingController phoneNumberController = TextEditingController(text: '9876543210');
  TextEditingController passwordController = TextEditingController(text: 'Password123');

  // Text editing controllers for student details
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController busNumberController = TextEditingController();

  bool isEditing = false;

  void addStudent() {
    setState(() {
      rollNumberController.clear();
      nameController.clear();
      schoolController.clear();
      routeController.clear();
      busNumberController.clear();
      isEditing = true; // Enable the Save button
    });
  }

  void removeStudent(String rollNumber) {
    setState(() {
      students.removeWhere((student) => student['rollNumber'] == rollNumber);
      selectedStudent = '';
    });
  }

  void saveStudent() {
    setState(() {
      // Save or edit student details
      if (selectedStudent.isEmpty) {
        students.add({
          'rollNumber': rollNumberController.text,
          'name': nameController.text,
          'school': schoolController.text,
          'route': routeController.text,
          'busNumber': busNumberController.text,
        });
      } else {
        Map<String, String> student = students
            .firstWhere((student) => student['rollNumber'] == selectedStudent);
        student['rollNumber'] = rollNumberController.text;
        student['name'] = nameController.text;
        student['school'] = schoolController.text;
        student['route'] = routeController.text;
        student['busNumber'] = busNumberController.text;
      }
      selectedStudent = '';
      isEditing = false;
    });
  }

  void cancelEditing() {
    setState(() {
      selectedStudent = '';
      isEditing = false;
      rollNumberController.clear();
      nameController.clear();
      schoolController.clear();
      routeController.clear();
      busNumberController.clear();
    });
  }

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
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Navigate to Home Page when center button is pressed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF6F6F6),
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
                      _onItemTapped('left');
                    },
                  ),
                  const SizedBox(width: 30), // Space for the elevated button
                  // Right Button (dynamically swapping with the center)
                  IconButton(
                    icon: Icon(_rightIcon, size: 30, color: Colors.white),
                    onPressed: () {
                      _onItemTapped('right');
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
                  _centerIcon,
                  size: 40,
                  color: Colors.white,
                ),
                onPressed: () {
                  _onItemTapped('center');
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            // Account Details Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Details',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: 10),
                  _buildTextField('Phone Number', phoneNumberController, false),
                  SizedBox(height: 10),
                  _buildTextField('Password', passwordController, isPasswordEditable),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPasswordEditable = !isPasswordEditable;
                        // Optionally, toggle password visibility
                        if (isPasswordEditable) {
                          passwordController.text = password; // Show actual password
                        } else {
                          passwordController.text = '********'; // Hide password
                        }
                      });
                    },
                    child: Text(isPasswordEditable ? 'Done' : 'Edit'),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Manage Students Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Manage Students',
                      style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 10),

                  // Dropdown for selecting student
                  DropdownButton<String>(
                    value: selectedStudent.isNotEmpty ? selectedStudent : null,
                    hint: Text('Select a student'),
                    onChanged: (newValue) {
                      setState(() {
                        selectedStudent = newValue!;
                        Map<String, String> student = students.firstWhere(
                            (student) =>
                                student['rollNumber'] == selectedStudent);
                        rollNumberController.text = student['rollNumber']!;
                        nameController.text = student['name']!;
                        schoolController.text = student['school']!;
                        routeController.text = student['route']!;
                        busNumberController.text = student['busNumber']!;
                      });
                    },
                    items: students.map((student) {
                      return DropdownMenuItem(
                        value: student['rollNumber'],
                        child: Text(student['name']!),
                      );
                    }).toList(),
                  ),

                  // Text fields for student details
                  SizedBox(height: 10),
                  _buildTextField('Roll Number', rollNumberController),
                  SizedBox(height: 10),
                  _buildTextField('Name', nameController),
                  SizedBox(height: 10),
                  _buildTextField('School', schoolController),
                  SizedBox(height: 10),
                  _buildTextField('Route', routeController),
                  SizedBox(height: 10),
                  _buildTextField('Bus Number', busNumberController),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (isEditing)
                        ElevatedButton(
                          onPressed: cancelEditing,
                          child: Text('Cancel'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ElevatedButton(
                        onPressed: isEditing ? saveStudent : addStudent,
                        child: Text(isEditing ? 'Save' : 'Add New Student'),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Student List',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ...students.map((student) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(student['name']!),
                        subtitle: Text('Roll Number: ${student['rollNumber']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            removeStudent(student['rollNumber']!);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, [bool isEditable = true]) {
    return TextField(
      controller: controller,
      enabled: isEditable,
      obscureText: label == 'Password' && !isPasswordEditable,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
