import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'screens/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Removed the database URL from here
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skoolyatra',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // Setting LoginPage as the initial screen
    );
  }
}
