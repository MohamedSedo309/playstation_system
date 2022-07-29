import 'package:flutter/material.dart';
import 'package:playstation_system/Auth/User_model.dart';
import 'package:playstation_system/Auth/login_screen.dart';
import 'package:playstation_system/Screens/Cashir.dart';
import 'package:playstation_system/Screens/Devices_Management.dart';

import '../main.dart';
import 'Drinks_Management.dart';
import 'Users_Management.dart';

class HomePage extends StatefulWidget {
  static const screenID = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User current_user = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wall2.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Cashier.screenID);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: build_container('Cashier', Icons.computer),
                ),
              ),
              GestureDetector(
                onTap: () {
                  current_user.isAdmin == 0
                      ? showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text(
                                'Not Available For This User',
                                style: TextStyle(fontSize: 25),
                              ),
                              actions: [
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: Text('OK'),
                                  ),
                                )
                              ],
                            );
                          })
                      : Navigator.pushNamed(
                          context, Devices_Managment.screenID);
                },
                child: build_container('Devices', Icons.gamepad),
              ),
              GestureDetector(
                  onTap: () {
                    current_user.isAdmin == 0
                        ? showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text(
                                  'Not Available For This User',
                                  style: TextStyle(fontSize: 25),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: Text('OK'),
                                    ),
                                  )
                                ],
                              );
                            })
                        : Navigator.pushNamed(
                            context, Drinks_Managment.screenID);
                  },
                  child: build_container('Drinks', Icons.wine_bar_sharp)),
              GestureDetector(
                  onTap: () {
                    current_user.isAdmin == 0
                        ? showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text(
                                  'Not Available For This User',
                                  style: TextStyle(fontSize: 25),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: Text('OK'),
                                    ),
                                  )
                                ],
                              );
                            })
                        : Navigator.pushNamed(
                            context, Users_Management.screenID);
                  },
                  child: build_container('Users', Icons.person)),
              GestureDetector(
                  onTap: () {
                    current_user.isAdmin == 0
                        ? showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: const Text(
                                  'Not Available For This User',
                                  style: TextStyle(fontSize: 25),
                                ),
                                actions: [
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(ctx);
                                      },
                                      child: Text('OK'),
                                    ),
                                  )
                                ],
                              );
                            })
                        : Navigator.pushNamed(
                            context, Devices_Managment.screenID);
                  },
                  child: build_container('Funds', Icons.money_off)),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.screenID);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: build_container('Logout', Icons.logout),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget build_container(String text, IconData icon) {
    return ClipOval(
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: 320,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(22, 32, 52, 1),
                fontSize: 30,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              size: 35,
              color: Color.fromRGBO(22, 32, 52, 1),
            ),
          ],
        ),
      ),
    );
  }
}
