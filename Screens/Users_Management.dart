import 'package:flutter/material.dart';
import 'package:playstation_system/Auth/User_model.dart';
import 'package:playstation_system/Auth/users_Database.dart';
import 'package:google_fonts/google_fonts.dart';

class Users_Management extends StatefulWidget {
  static const screenID = 'Users_Management';

  @override
  State<Users_Management> createState() => _Users_ManagementState();
}

class _Users_ManagementState extends State<Users_Management> {
  Users_DB users_db = Users_DB();

  List<User> users_list = [];

  String new_id = '';

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  TextEditingController username_ctrl = TextEditingController();
  TextEditingController password_ctrl = TextEditingController();
  bool isAdmin = false;

  @override
  void initState() {
    refresh_users_list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'إدارة المستخدمين',
          style: GoogleFonts.elMessiri(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.amber[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.amber[800]!,
              Colors.amber[600]!,
              Colors.amber[400]!,
              Colors.amber[200]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Form(
                key: form_key,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        submit();
                      },
                      child: Center(
                        child: Container(
                          width: width / 7.68,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '+  إضافة',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.elMessiri(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          tristate: true,
                          value: isAdmin,
                          onChanged: (val) {
                            setState(() {
                              isAdmin = val == null ? false : true;
                            });
                          },
                          activeColor: Colors.black45,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'حساب المدير',
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: width / 7.68,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            key: const ValueKey('password'),
                            validator: (value) {
                              if (value!.isEmpty) return 'أدخل كلمة السر';
                            },
                            onSaved: (val) {
                              setState(() {
                                password_ctrl.text = val!;
                              });
                            },
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            controller: password_ctrl,
                            decoration: InputDecoration(
                              hintText: "كلمة السر",
                              hintStyle: const TextStyle(color: Colors.black38),
                              hintTextDirection: TextDirection.rtl,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'كلمة السر',
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40,
                          width: width / 7.68,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            key: const ValueKey('username'),
                            validator: (value) {
                              if (value!.isEmpty) return 'أدخل إسم المستخدم';
                            },
                            onSaved: (val) {
                              setState(() {
                                username_ctrl.text = val!;
                              });
                            },
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            controller: username_ctrl,
                            decoration: InputDecoration(
                              hintText: "إسم المستخدم",
                              hintStyle: const TextStyle(color: Colors.black38),
                              hintTextDirection: TextDirection.rtl,
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              errorStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'إسم المستخدم',
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: width * 0.9,
              padding: const EdgeInsets.only(
                top: 40,
                right: 15,
                left: 15,
                bottom: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Table(
                      columnWidths: const {
                        5: FlexColumnWidth(0.5),
                        4: FlexColumnWidth(1.5),
                        3: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1),
                        1: FlexColumnWidth(0.5),
                        0: FlexColumnWidth(0.5),
                      },
                      border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      children: const [
                        TableRow(
                          children: [
                            Text(
                              'حذف',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              'تعديل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              'مدير',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text(
                              'كلمة السر',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: Text(
                                'إسم المستخدم',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Text(
                              'م',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Table(
                      columnWidths: const {
                        5: FlexColumnWidth(0.5),
                        4: FlexColumnWidth(1.5),
                        3: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1),
                        1: FlexColumnWidth(0.5),
                        0: FlexColumnWidth(0.5),
                      },
                      border: TableBorder.all(
                        color: Colors.black,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      children:
                          List<TableRow>.generate(users_list.length, (index) {
                        return TableRow(
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                          'هل تريد حذف هذا المستخدم ؟',
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                users_db.delete_user(
                                                    users_list[index].id!);
                                                Navigator.pop(ctx);
                                                refresh_users_list();
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.amberAccent,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'نعم',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(ctx);
                                              },
                                              child: Container(
                                                width: 50,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.amberAccent,
                                                ),
                                                child: const Center(
                                                    child: Text(
                                                  'لا',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  new_id = users_list[index].id.toString();
                                  username_ctrl.text = users_list[index].name;
                                  password_ctrl.text =
                                      users_list[index].password;
                                  isAdmin = users_list[index].isAdmin == 0
                                      ? false
                                      : true;
                                });
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            Icon(
                              users_list[index].isAdmin == 1
                                  ? Icons.check
                                  : Icons.close,
                              color: users_list[index].isAdmin == 1
                                  ? Colors.green
                                  : Colors.red,
                              size: 35,
                            ),
                            Text(
                              users_list[index].password,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              users_list[index].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              (index + 1).toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() {
    form_key.currentState!.validate();
    if (!form_key.currentState!.validate()) {
      return;
    } else if (users_list.any((element) => element.id == int.parse(new_id)) ==
        true) {
      form_key.currentState!.save();
      users_db.updateDB(
          User(
              name: username_ctrl.text,
              password: password_ctrl.text,
              isAdmin: isAdmin ? 1 : 0),
          int.parse(new_id));

      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'تم تعديل المستخدم',
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 80,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amberAccent,
                      ),
                      child: const Center(
                          child: Text(
                        'ok',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            );
          });
      setState(() {
        username_ctrl.text = '';
        password_ctrl.text = '';
        isAdmin = false;
      });
      form_key.currentState!.reset();
      refresh_users_list();
    } else {
      form_key.currentState!.save();
      users_db.createItem(User(
          name: username_ctrl.text,
          password: password_ctrl.text,
          isAdmin: isAdmin ? 1 : 0));
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'تم إضافة المستخدم',
                textAlign: TextAlign.center,
              ),
              content: Container(
                height: 80,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(ctx);
                    },
                    child: Container(
                      width: 50,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amberAccent,
                      ),
                      child: const Center(
                          child: Text(
                        'ok',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ),
              ),
            );
          });
      setState(() {
        username_ctrl.text = '';
        password_ctrl.text = '';
        isAdmin = false;
      });

      form_key.currentState!.reset();
      refresh_users_list();
    }
  }

  refresh_users_list() async {
    await users_db.get_DB();
    await users_db.intializeDB();
    users_list = await users_db.readAllData();
    if (users_list.isNotEmpty) {
      setState(() {
        new_id = (users_list.last.id! + 1).toString();
      });
    }
  }
}
