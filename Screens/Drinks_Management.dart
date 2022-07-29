import 'package:flutter/material.dart';
import 'package:playstation_system/Databases/drinks_database.dart';

class Drinks_Managment extends StatefulWidget {
  static const screenID = 'Drinks_Managment';

  @override
  State<Drinks_Managment> createState() => _Drinks_ManagmentState();
}

class _Drinks_ManagmentState extends State<Drinks_Managment> {
  Drinks_DB drinks_db = Drinks_DB();

  @override
  void initState() {
    get_database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  get_database() async {
    await drinks_db.get_DB();
    await drinks_db.intializeDB();
  }
}
