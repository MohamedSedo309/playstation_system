import 'package:flutter/material.dart';
import 'package:playstation_system/Screens/Homepage.dart';

import '../constants/constants.dart';
import 'User_model.dart';
import 'users_Database.dart';

class LoginScreen extends StatefulWidget {
  static const screenID = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final form_key = GlobalKey<FormState>();
  Users_DB users_db = Users_DB();
  List<User> users_list = [];

  bool see_password = true;
  TextEditingController username_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();

  @override
  void initState() {
    get_users_list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: form_key,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/wall.jpg'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 100, bottom: 10),
                child: SizedBox(
                  width: width * 0.3,
                  child: TextFormField(
                    key: const ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل إسم المستخدم';
                      }
                    },
                    onSaved: (val) {
                      username_ctrl.text = val!;
                    },
                    controller: username_ctrl,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                      fillColor: Color.fromRGBO(8, 12, 21, 1),
                      filled: true,
                      hintTextDirection: TextDirection.ltr,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hieght * 0.06,
              ),
              Padding(
                padding: EdgeInsets.only(right: 100, bottom: 10),
                child: SizedBox(
                  width: width * 0.3,
                  child: TextFormField(
                    key: const ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل كلمة السر';
                      }
                    },
                    onSaved: (val) {
                      password_ctrl.text = val!;
                    },
                    controller: password_ctrl,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    obscureText: see_password,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      hintTextDirection: TextDirection.ltr,
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 35,
                        color: Colors.white,
                      ),
                      suffix: IconButton(
                        icon: Icon(
                          see_password == false
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            see_password = !see_password;
                          });
                        },
                      ),
                      fillColor: Color.fromRGBO(8, 12, 21, 1),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(12, 49, 78, 1),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorStyle: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: hieght * 0.06,
              ),
              Padding(
                padding: EdgeInsets.only(right: 180, bottom: 200),
                child: GestureDetector(
                  onTap: () {
                    submit();
                  },
                  child: Container(
                    width: 300,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white60,
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(8, 12, 21, 1),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submit() {
    User user;
    form_key.currentState!.validate();
    form_key.currentState!.save();

    if (users_list.any((element) =>
        element.name == username_ctrl.text &&
        element.password == password_ctrl.text)) {
      print(1);
      user = users_list.singleWhere((element) =>
          element.name == username_ctrl.text &&
          element.password == password_ctrl.text);
      Navigator.pushNamed(context, HomePage.screenID, arguments: user);
    } else {
      print(2);

      showDialog(
          context: context,
          builder: (ctc) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'تأكد من اسم المستخدم و كلمة المرور',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctc);
                    },
                    child: Text('OK'),
                  ),
                )
              ],
            );
          });
    }
  }

  get_users_list() async {
    await users_db.get_DB();
    await users_db.intializeDB();
    users_list = await users_db.readAllData();
  }
}
