import 'package:flutter/material.dart';

class ConductorPage extends StatefulWidget {
  @override
  _ConductorPageState createState() => _ConductorPageState();
}

class _ConductorPageState extends State<ConductorPage> {
  bool isBusDetailsEditable = false;
  bool isConductorDetailsEditable = false;
  bool isEditingStudent = false;
  bool isAddingStudent = false; 
  bool isAccountDetailsEditable = false; // For Account Details section
  Student? selectedStudent;

  // Sample student data with roll numbers for indexing
  List<Student> students = [
    Student(rollNumber: 1, name: "John Doe", checked: false, boardingTime: "08:00 AM"),
    Student(rollNumber: 2, name: "Jane Smith", checked: false, boardingTime: "08:05 AM"),
    Student(rollNumber: 3, name: "Sam Wilson", checked: false, boardingTime: "08:10 AM", remarks: "On Leave"),
  ];

  // Bus and school details
  TextEditingController schoolNameController = TextEditingController(text: "Green Valley School");
  TextEditingController busNumberController = TextEditingController(text: "KL46J1234");
  TextEditingController busMakeModelController = TextEditingController(text: "Toyota HiAce");
  TextEditingController busCapacityController = TextEditingController(text: "45");
  TextEditingController driverNameController = TextEditingController(text: "Rajesh Kumar");

  // Conductor details
  TextEditingController conductorNameController = TextEditingController(text: "Suresh Nair");
  TextEditingController conductorPhoneController = TextEditingController(text: "9876543210");

  // Student details for editing
  TextEditingController rollNumberController = TextEditingController();
  TextEditingController studentNameController = TextEditingController();
  TextEditingController boardingTimeController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  // Account details
  TextEditingController accountPhoneController = TextEditingController(text: "9876543210");
  TextEditingController accountPasswordController = TextEditingController(text: "password123");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Row(
          children: [
            Image.asset('images/company_logo.png', height: 40),
            Text(" SchoolYatra", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            Spacer(),
            TextButton(
              onPressed: () {
                // Add logout logic
              },
              child: Text(
                'Log Out',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Welcome message
              Text(
                'Welcome, Conductor!',
                style: TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Student list heading
              Text(
                'Mark Attendance of Students as they arrive from the following list:',
                style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              // Student ListView
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return buildStudentTile(index);
                },
              ),
              SizedBox(height: 16),

              // Bus details heading
              buildSectionHeader('Bus and School Details', () {
                setState(() {
                  isBusDetailsEditable = !isBusDetailsEditable;
                });
              }, isBusDetailsEditable, showEditButton: true),

              // School Name and Bus details
              buildTextField('School Name', schoolNameController, isBusDetailsEditable),
              buildTextField('Bus Number', busNumberController, isBusDetailsEditable),
              buildTextField('Bus Make and Model', busMakeModelController, isBusDetailsEditable),
              buildTextField('Bus Capacity', busCapacityController, isBusDetailsEditable),
              buildTextField('Bus Driver Name', driverNameController, isBusDetailsEditable),

              SizedBox(height: 16),

              // Conductor details heading
              buildSectionHeader('Conductor Details', () {
                setState(() {
                  isConductorDetailsEditable = !isConductorDetailsEditable;
                });
              }, isConductorDetailsEditable, showEditButton: true),

              // Conductor details
              buildTextField('Conductor Name', conductorNameController, isConductorDetailsEditable),
              buildTextField('Phone Number of Conductor', conductorPhoneController, isConductorDetailsEditable),

              SizedBox(height: 16),

              // Account details heading
              buildSectionHeader('Account Details', () {
                setState(() {
                  isAccountDetailsEditable = !isAccountDetailsEditable;
                });
              }, isAccountDetailsEditable, showEditButton: true),

              // Account details
              buildTextField('Account Phone Number', accountPhoneController, isAccountDetailsEditable),
              buildTextField('Account Password', accountPasswordController, isAccountDetailsEditable, obscureText: true),

              SizedBox(height: 16),

              // Student Management Container
              buildSectionHeader('Manage Student Details', () {}, false, showEditButton: false),

              // Dropdown for selecting student
              DropdownButton<Student>(
                value: selectedStudent,
                hint: Text('Select Student'),
                isExpanded: true,
                onChanged: (Student? newValue) {
                  setState(() {
                    selectedStudent = newValue;
                    rollNumberController.text = selectedStudent?.rollNumber.toString() ?? '';
                    studentNameController.text = selectedStudent?.name ?? '';
                    boardingTimeController.text = selectedStudent?.boardingTime ?? '';
                    remarksController.text = selectedStudent?.remarks ?? 'None';
                    isEditingStudent = false; // Reset editing mode when new student is selected
                    isAddingStudent = false; // Reset adding mode
                  });
                },
                items: students.map((Student student) {
                  return DropdownMenuItem<Student>(
                    value: student,
                    child: Text('${student.rollNumber}: ${student.name}'), // Show roll number in dropdown
                  );
                }).toList(),
              ),
              SizedBox(height: 16),

              // Student details input fields
              buildTextField('Roll Number', rollNumberController, isEditingStudent || isAddingStudent),
              buildTextField('Student Name', studentNameController, isEditingStudent || isAddingStudent),
              buildTextField('Boarding Time', boardingTimeController, isEditingStudent || isAddingStudent),

              // Edit/Save/Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (isEditingStudent) {
                        setState(() {
                          isEditingStudent = false;
                          rollNumberController.clear();
                          studentNameController.clear();
                          boardingTimeController.clear();
                        });
                      } else if (isAddingStudent) {
                        setState(() {
                          isAddingStudent = false;
                          rollNumberController.clear();
                          studentNameController.clear();
                          boardingTimeController.clear();
                        });
                      } else {
                        setState(() {
                          isEditingStudent = true; // Enable editing for selected student
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isEditingStudent || isAddingStudent ? Colors.red : Colors.amber[800],
                    ),
                    child: Text(isEditingStudent ? 'Cancel' : isAddingStudent ? 'Cancel' : 'Edit'),
                  ),
                  if (isEditingStudent)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedStudent?.name = studentNameController.text;
                          selectedStudent?.boardingTime = boardingTimeController.text;
                          selectedStudent?.rollNumber = int.tryParse(rollNumberController.text) ?? selectedStudent!.rollNumber; // Update roll number
                          isEditingStudent = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text('Save'),
                    ),
                  if (isAddingStudent)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          int newRollNumber = int.tryParse(rollNumberController.text) ?? students.length + 1;
                          students.add(Student(
                            rollNumber: newRollNumber,
                            name: studentNameController.text,
                            boardingTime: boardingTimeController.text,
                          ));
                          rollNumberController.clear();
                          studentNameController.clear();
                          boardingTimeController.clear();
                          isAddingStudent = false; // Reset adding mode
                        });
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text('Save'),
                    ),
                ],
              ),
              SizedBox(height: 16),

              // Add/Remove Student Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Clear fields and enable adding student mode
                        rollNumberController.clear();
                        studentNameController.clear();
                        boardingTimeController.clear();
                        isAddingStudent = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Add Student'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (selectedStudent != null) {
                          students.remove(selectedStudent);
                          selectedStudent = null;
                          rollNumberController.clear();
                          studentNameController.clear();
                          boardingTimeController.clear();
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Remove Student'),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget buildTextField(String label, TextEditingController controller, bool isEditable, {bool obscureText = false}) {
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
        keyboardType: label == 'Roll Number' ? TextInputType.number : TextInputType.text, // Numeric keyboard for roll number
      ),
    );
  }

  // Function to build section header with Edit button
  Widget buildSectionHeader(String title, VoidCallback onPressed, bool isEditable, {bool showEditButton = true}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        if (showEditButton)
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
            ),
            child: Text(isEditable ? 'Save' : 'Edit', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
      ],
    );
  }

  // Function to build student tile with remarks and onboarding/offboarding button
  Widget buildStudentTile(int index) {
    final student = students[index];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.amber[300],
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            '${student.rollNumber}: ${student.name}', // Show roll number with student name
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Boarding Time: ${student.boardingTime}'),
              if (student.remarks != 'None')
                Text(
                  'Remarks: ${student.remarks}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              setState(() {
                student.checked = !student.checked;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: student.checked ? Colors.red : Colors.green,
            ),
            child: Text(student.checked ? 'Off Bus' : 'On Bus'),
          ),
        ),
      ),
    );
  }
}

// Student class with roll number for indexing
class Student {
  int rollNumber;
  String name;
  bool checked;
  String boardingTime;
  String remarks;

  Student({
    required this.rollNumber,
    required this.name,
    this.checked = false,
    required this.boardingTime,
    this.remarks = 'None',
  });
}
