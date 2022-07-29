import 'package:flutter/material.dart';
import 'package:playstation_system/Screens/Cashir.dart';
import 'package:playstation_system/Screens/Devices_Management.dart';
import 'package:playstation_system/Screens/Homepage.dart';
import 'Auth/login_screen.dart';
import 'Screens/Drinks_Management.dart';
import 'Screens/Users_Management.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playstation',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        LoginScreen.screenID: (context) => LoginScreen(),
        HomePage.screenID: (context) => HomePage(),
        Cashier.screenID: (context) => Cashier(),
        Devices_Managment.screenID: (context) => Devices_Managment(),
        Users_Management.screenID: (context) => Users_Management(),
        Drinks_Managment.screenID: (context) => Drinks_Managment(),
      },
    );
  }
}
