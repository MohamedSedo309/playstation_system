import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playstation_system/Databases/device_Model.dart';
import 'package:playstation_system/Databases/devices_database.dart';

class Devices_Managment extends StatefulWidget {
  static const screenID = 'Devices_Managment';

  @override
  State<Devices_Managment> createState() => _Devices_ManagmentState();
}

class _Devices_ManagmentState extends State<Devices_Managment> {
  var devices_db = Devices_DB();
  String new_id = '';

  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  TextEditingController name_ctrl = TextEditingController();

  TextEditingController type_ctrl = TextEditingController();

  TextEditingController sPrice_ctrl = TextEditingController();

  TextEditingController mPrice_ctrl = TextEditingController();

  List<Device> devices_list = [];
  List<DropdownMenuItem<String>> types_list = [
    const DropdownMenuItem(value: 'PS 5', child: Text('PS 5')),
    const DropdownMenuItem(value: 'PS 4', child: Text('PS 4')),
    const DropdownMenuItem(value: 'Billiards', child: Text('Billiards')),
    const DropdownMenuItem(value: 'PingPongs', child: Text('PingPongs')),
    const DropdownMenuItem(value: 'Table', child: Text('Table')),
  ];

  @override
  void initState() {
    refresh_devices_list();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'إدارة الأجهزة',
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: (width * 0.7) - 2,
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
                        6: FlexColumnWidth(0.5),
                        5: FlexColumnWidth(3),
                        4: FlexColumnWidth(2),
                        3: FlexColumnWidth(1),
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
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'تعديل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              'Multi',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Single',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'النوع',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'إسم الجهاز',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'م',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Table(
                        columnWidths: const {
                          6: FlexColumnWidth(0.5),
                          5: FlexColumnWidth(3),
                          4: FlexColumnWidth(2),
                          3: FlexColumnWidth(1),
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
                        children: List<TableRow>.generate(devices_list.length,
                            (index) {
                          return TableRow(
                            children: [
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          title: const Text(
                                            'هل تريد حذف هذا الجهاز ؟',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  devices_db.delete_device(
                                                      devices_list[index].id!);
                                                  Navigator.pop(ctx);
                                                  refresh_devices_list();
                                                },
                                                child: Container(
                                                  width: 50,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
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
                                                  decoration:
                                                      const BoxDecoration(
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
                                    new_id = devices_list[index].id.toString();
                                    name_ctrl.text = devices_list[index].name;
                                    type_ctrl.text = devices_list[index].type;
                                    sPrice_ctrl.text = devices_list[index]
                                        .price_single
                                        .toString();
                                    mPrice_ctrl.text = devices_list[index]
                                        .price_multy
                                        .toString();
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(
                                devices_list[index].price_multy.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                devices_list[index].price_single.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                devices_list[index].type,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                devices_list[index].name,
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black,
              width: 2,
              height: hieght,
            ),
            Form(
              key: form_key,
              child: Container(
                width: (width * 0.3) - 1,
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          width: width / 15.36,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                              child: Text(
                            new_id,
                            style: const TextStyle(fontSize: 20),
                          )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'كود الجهاز',
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
                        SizedBox(
                          width: width / 7.68,
                          child: TextFormField(
                            key: const ValueKey('device_name'),
                            validator: (value) {
                              if (value!.isEmpty) return 'أدخل إسم الجهاز';
                            },
                            onSaved: (val) {
                              setState(() {
                                name_ctrl.text = val!;
                              });
                            },
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            controller: name_ctrl,
                            decoration: InputDecoration(
                              hintText: "إسم الجهاز",
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
                          'إسم الجهاز',
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: DropdownButton<String>(
                            value: type_ctrl.text == '' ? null : type_ctrl.text,
                            hint: const Text('إختر النوع'),
                            borderRadius: BorderRadius.circular(15),
                            focusColor: Colors.transparent,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            onChanged: (val) {
                              setState(() {
                                type_ctrl.text = val!;
                              });
                            },
                            items: types_list,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'نوع الجهاز',
                          textAlign: TextAlign.start,
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
                        SizedBox(
                          width: width / 8,
                          child: TextFormField(
                            key: const ValueKey('sprice'),
                            validator: (value) {
                              if (value!.isEmpty) return 'أدخل سعر الساعة';
                              if (int.tryParse(value) == null) {
                                return 'أدخل سعر الساعة';
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                sPrice_ctrl.text = val!;
                              });
                            },
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            controller: sPrice_ctrl,
                            decoration: InputDecoration(
                              hintText: "سعر الساعة",
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
                          'Single سعر الساعة',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: width / 8,
                          child: TextFormField(
                            key: const ValueKey('mprice'),
                            validator: (value) {
                              if (value!.isEmpty) return 'أدخل سعر الساعة';
                              if (int.tryParse(value) == null) {
                                print(value);
                                return 'أدخل سعر الساعة';
                              }
                            },
                            onSaved: (val) {
                              setState(() {
                                mPrice_ctrl.text = val!;
                              });
                            },
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            controller: mPrice_ctrl,
                            decoration: InputDecoration(
                              hintText: "سعر الساعة",
                              hintStyle: const TextStyle(color: Colors.black38),
                              hintTextDirection: TextDirection.ltr,
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
                          'Multi سعر الساعة',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.tajawal(
                            fontSize: width / 61.44,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  submit() async {
    form_key.currentState!.validate();
    if (!form_key.currentState!.validate()) {
      return;
    } else if (devices_list.any((element) => element.id == int.parse(new_id)) ==
        true) {
      form_key.currentState!.save();

      devices_db.updateDB(
          Device(
            name: name_ctrl.text,
            type: type_ctrl.text,
            price_single: int.parse(sPrice_ctrl.text),
            price_multy: int.parse(mPrice_ctrl.text),
            isActive: 0,
          ),
          int.parse(
            new_id,
          ));

      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'تم تعديل الجهاز',
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

      name_ctrl.clear();
      type_ctrl.clear();
      sPrice_ctrl.clear();
      mPrice_ctrl.clear();
      form_key.currentState!.reset();
      new_id = (devices_list.last.id! + 1).toString();

      refresh_devices_list();
    } else {
      form_key.currentState!.save();

      devices_db.createItem(
        Device(
          name: name_ctrl.text,
          type: type_ctrl.text,
          price_single: int.parse(sPrice_ctrl.text),
          price_multy: int.parse(mPrice_ctrl.text),
          isActive: 0,
        ),
      );
      name_ctrl.clear();
      type_ctrl.clear();
      sPrice_ctrl.clear();
      mPrice_ctrl.clear();
      form_key.currentState!.reset();

      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text(
                'تم إضافة الجهاز',
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

      refresh_devices_list();
    }
  }

  refresh_devices_list() async {
    await devices_db.get_DB();
    await devices_db.intializeDB();
    devices_list = await devices_db.readAllData();
    if (devices_list.isNotEmpty) {
      setState(() {
        new_id = (devices_list.last.id! + 1).toString();
      });
    }
  }
}
