import 'package:flutter/material.dart';

class ConductorPage extends StatefulWidget {
  @override
  _ConductorPageState createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  bool isEditable = false;

  // Sample student data
  List<Student> students = [
    Student(name: "John Doe", checked: false),
    Student(name: "Jane Smith", checked: false),
    Student(name: "Sam Wilson", checked: false),
    Student(name: "Souvik Goswami", checked: false),
    Student(name: "Ouvik Oswami", checked: false),
    Student(name: "Uvik Swami", checked: false),
    Student(name: "Vik Wami", checked: false),
    Student(name: "Ik Wam", checked: false),
    Student(name: "Kam", checked: false),
  ];

  // Bus details (initially not editable)
  TextEditingController busNumberController = TextEditingController(text: "KL46J1234");
  TextEditingController busMakeModelController = TextEditingController(text: "Toyota HiAce");
  TextEditingController busCapacityController = TextEditingController(text: "45");
  TextEditingController driverNameController = TextEditingController(text: "Rajesh Kumar");
  TextEditingController conductorNameController = TextEditingController(text: "Suresh Nair");
  TextEditingController conductorPhoneController = TextEditingController(text: "9876543210");
  TextEditingController usernameController = TextEditingController(text: "conductor123");
  TextEditingController passwordController = TextEditingController(text: "password");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800], // Dark yellow shade
        title: Row(
          children: [
            Image.asset('assets/company_logo.png', height: 40), // Company logo
            Text(" SchoolYatra",style: TextStyle(color: Color(0xFFFFFFFF),fontWeight: FontWeight.bold),),
            Spacer(),
            TextButton(
              onPressed: () {
                // Add logout logic
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                'Welcome, Conductor!',
                style: TextStyle(fontSize: 27, color: Colors.amber[800],) // Dark yellow for text
              ),

              SizedBox(height: 16),

              // Student list heading
              Text(
                'Student List',
                style: TextStyle(fontSize: 16, color: Colors.amber[800]), // Dark yellow for text
              ),

              // Student ListView
              ListView.builder(
                shrinkWrap: true, // To avoid infinite height
                physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(students[index].name),
                    trailing: Checkbox(
                      value: students[index].checked,
                      onChanged: (bool? value) {
                        setState(() {
                          students[index].checked = value ?? false;
                        });
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: 16),

              // Bus details heading
              Text(
                'Bus Details',
                style: TextStyle(fontSize: 16, color: Colors.amber[800]), // Dark yellow for text
              ),

              SizedBox(height: 8),

              // Bus number (editable on button press)
              buildTextField('Bus Number', busNumberController),

              // Bus make and model
              buildTextField('Bus Make and Model', busMakeModelController),

              // Bus capacity
              buildTextField('Bus Capacity', busCapacityController),

              // Bus driver name
              buildTextField('Bus Driver Name', driverNameController),

              // Bus conductor name
              buildTextField('Bus Conductor Name', conductorNameController),

              // Conductor phone number
              buildTextField('Phone Number of Conductor', conductorPhoneController),

              // Username
              buildTextField('Username', usernameController),

              // Password
              buildTextField('Password', passwordController, obscureText: true),

              SizedBox(height: 16),

              // Edit button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isEditable = !isEditable;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[800], // Dark yellow button color
                ),
                child: Text(isEditable ? 'Save' : 'Edit',style: TextStyle(fontWeight: FontWeight.bold ),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        readOnly: !isEditable,
      ),
    );
  }
}

class Student {
  String name;
  bool checked;

  Student({required this.name, this.checked = false});
}
