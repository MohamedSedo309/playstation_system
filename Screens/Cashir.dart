import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playstation_system/Databases/OrderItem_Model.dart';
import 'package:playstation_system/Databases/Order_Model.dart';
import 'package:playstation_system/Databases/Order_database.dart';
import 'package:playstation_system/Databases/devices_database.dart';
import 'package:playstation_system/Databases/drink_Model.dart';
import 'package:playstation_system/Databases/drinks_database.dart';

import '../Databases/OrderIem_database.dart';
import '../Databases/device_Model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Cashier extends StatefulWidget {
  static const screenID = 'Cashier';

  @override
  State<Cashier> createState() => _CashierState();
}

class _CashierState extends State<Cashier> {
  Orders_DB orders_db = Orders_DB();
  Devices_DB devices_db = Devices_DB();
  Drinks_DB drinks_db = Drinks_DB();
  OrderItems_DB orderItems_DB = OrderItems_DB();

  int count = 1;
  int ps_radioval = 0;
  int print_radioval = 0;

  int? selected_device_index;

  int? selected_ORDER_id;
  int? selected_ORDER_index;

  final ScrollController controller0 = ScrollController();
  final ScrollController controller1 = ScrollController();
  final ScrollController controller2 = ScrollController();

  List<Device> available_devices = [];
  List<Drink> drinks_list = [];
  List<Order> orders_list = [];
  List<Order_Item> orderITEMs_list = [];

  Color field_Color = const Color.fromRGBO(160, 162, 165, 1);
  Color border_Color = const Color.fromRGBO(38, 74, 154, 1);

  @override
  void initState() {
    get_Orders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hieght = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(10, 13, 21, 1),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(10, 13, 21, 1),
        ),
        width: double.infinity,
        child: Column(
          children: [
            Table(
              columnWidths: const {
                4: FlexColumnWidth(3),
                3: FlexColumnWidth(2),
                2: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                0: FlexColumnWidth(4),
              },
              border: TableBorder.all(
                color: border_Color,
                style: BorderStyle.solid,
                width: 4,
              ),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: field_Color,
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.computer,
                            size: 45,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'الكاشير',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(10, 13, 21, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'العدد',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(10, 13, 21, 1),
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          'السعر',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(10, 13, 21, 1),
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.wine_bar,
                            size: 45,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'المشروبات',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(10, 13, 21, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.gamepad_outlined,
                            size: 45,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'قائمة الأجهزة',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              color: Color.fromRGBO(10, 13, 21, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: hieght * 0.50,
              color: Colors.white,
              child: Row(
                children: [
                  // now playing devices
                  SizedBox(
                    width: (width / 11 * 4) - 2,
                    child: selected_ORDER_id == null
                        ? ListView.separated(
                            controller: controller2,
                            itemCount: orders_list.length,
                            itemBuilder: (ctx, index) {
                              return SizedBox(
                                height: 50,
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orders_list[index].name!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                        ),
                                      ),
                                      Text(
                                        orders_list[index].start_time.hour <=
                                                    10 &&
                                                orders_list[index]
                                                        .start_time
                                                        .minute <
                                                    10
                                            ? '0${orders_list[index].start_time.hour}:'
                                                '0${orders_list[index].start_time.minute}'
                                            : orders_list[index]
                                                            .start_time
                                                            .hour <=
                                                        10 &&
                                                    orders_list[index]
                                                            .start_time
                                                            .minute >
                                                        10
                                                ? '0${orders_list[index].start_time.hour}:'
                                                    '${orders_list[index].start_time.minute}'
                                                : orders_list[index]
                                                                .start_time
                                                                .hour >=
                                                            10 &&
                                                        orders_list[index]
                                                                .start_time
                                                                .minute <
                                                            10
                                                    ? '${orders_list[index].start_time.hour}:'
                                                        '0${orders_list[index].start_time.minute}'
                                                    : '${orders_list[index].start_time.hour}:'
                                                        '${orders_list[index].start_time.minute}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selected_ORDER_id = orders_list[index].id;
                                      selected_ORDER_index = index;
                                    });
                                    get_Order_Items(selected_ORDER_id!);
                                    print(selected_ORDER_id);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider(
                                thickness: 2,
                                color: border_Color,
                              );
                            },
                          )
                        : ListView(
                            children: [
                              ListTile(
                                title: Center(
                                  child: Text(
                                    orders_list[selected_ORDER_index!].name!,
                                    style: const TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: border_Color,
                              ),
                              ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orders_list[selected_ORDER_index!]
                                                      .start_time
                                                      .hour <=
                                                  10 &&
                                              orders_list[selected_ORDER_index!]
                                                      .start_time
                                                      .minute <
                                                  10
                                          ? '0${orders_list[selected_ORDER_index!].start_time.hour}:'
                                              '0${orders_list[selected_ORDER_index!].start_time.minute}'
                                          : orders_list[selected_ORDER_index!]
                                                          .start_time
                                                          .hour <=
                                                      10 &&
                                                  orders_list[selected_ORDER_index!]
                                                          .start_time
                                                          .minute >
                                                      10
                                              ? '0${orders_list[selected_ORDER_index!].start_time.hour}:'
                                                  '${orders_list[selected_ORDER_index!].start_time.minute}'
                                              : orders_list[selected_ORDER_index!]
                                                              .start_time
                                                              .hour >=
                                                          10 &&
                                                      orders_list[selected_ORDER_index!]
                                                              .start_time
                                                              .minute <
                                                          10
                                                  ? '${orders_list[selected_ORDER_index!].start_time.hour}:'
                                                      '0${orders_list[selected_ORDER_index!].start_time.minute}'
                                                  : '${orders_list[selected_ORDER_index!].start_time.hour}:'
                                                      '${orders_list[selected_ORDER_index!].start_time.minute}',
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                    const Text(
                                      ':',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    const Text(
                                      'وقت التشغيل',
                                      style: TextStyle(fontSize: 30),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: border_Color,
                              ),
                              if (orders_list[selected_ORDER_index!].end_time !=
                                  null)
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orders_list[selected_ORDER_index!]
                                                        .end_time!
                                                        .hour <=
                                                    10 &&
                                                orders_list[selected_ORDER_index!]
                                                        .end_time!
                                                        .minute <
                                                    10
                                            ? '0${orders_list[selected_ORDER_index!].end_time!.hour}:'
                                                '0${orders_list[selected_ORDER_index!].end_time!.minute}'
                                            : orders_list[selected_ORDER_index!]
                                                            .end_time!
                                                            .hour <=
                                                        10 &&
                                                    orders_list[selected_ORDER_index!]
                                                            .end_time!
                                                            .minute >
                                                        10
                                                ? '0${orders_list[selected_ORDER_index!].end_time!.hour}:'
                                                    '${orders_list[selected_ORDER_index!].end_time!.minute}'
                                                : orders_list[selected_ORDER_index!]
                                                                .end_time!
                                                                .hour >=
                                                            10 &&
                                                        orders_list[selected_ORDER_index!]
                                                                .end_time!
                                                                .minute <
                                                            10
                                                    ? '${orders_list[selected_ORDER_index!].end_time!.hour}:'
                                                        '0${orders_list[selected_ORDER_index!].end_time!.minute}'
                                                    : '${orders_list[selected_ORDER_index!].end_time!.hour}:'
                                                        '${orders_list[selected_ORDER_index!].end_time!.minute}',
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      const Text(
                                        ':',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      const Text(
                                        'وقت الإيقاف',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              if (orders_list[selected_ORDER_index!].end_time !=
                                  null)
                                Divider(
                                  thickness: 2,
                                  color: border_Color,
                                ),
                              if (orders_list[selected_ORDER_index!].end_time !=
                                  null)
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        orders_list[selected_ORDER_index!]
                                            .playstation_subtotal
                                            .toString(),
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                      const Text(
                                        ':',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      const Text(
                                        'إجمالي اللعب',
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              if (orders_list[selected_ORDER_index!].end_time !=
                                  null)
                                Divider(
                                  thickness: 2,
                                  color: border_Color,
                                ),
                              SizedBox(
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 165,
                                      child: Container(
                                        color: border_Color,
                                        height: 50,
                                        width: 2,
                                      ),
                                    ),
                                    Positioned(
                                      left: 310,
                                      child: Container(
                                        color: border_Color,
                                        height: 50,
                                        width: 2,
                                      ),
                                    ),
                                    Positioned(
                                      right: 130,
                                      child: Container(
                                        color: border_Color,
                                        height: 50,
                                        width: 2,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "المشروبات",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Text(
                                          "العدد",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Text(
                                          "السعر",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                          ),
                                        ),
                                        Text(
                                          "إجمالي",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2,
                                color: border_Color,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                controller: controller2,
                                itemCount: orderITEMs_list.length,
                                itemBuilder: (ctx, index) {
                                  return Stack(
                                    children: [
                                      Positioned(
                                        left: 165,
                                        child: Container(
                                          color: border_Color,
                                          height: 50,
                                          width: 2,
                                        ),
                                      ),
                                      Positioned(
                                        left: 310,
                                        child: Container(
                                          color: border_Color,
                                          height: 50,
                                          width: 2,
                                        ),
                                      ),
                                      Positioned(
                                        right: 130,
                                        child: Container(
                                          color: border_Color,
                                          height: 50,
                                          width: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              orderITEMs_list[index].name,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 35,
                                              ),
                                            ),
                                            Text(
                                              orderITEMs_list[index]
                                                  .quantity
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 35,
                                              ),
                                            ),
                                            Text(
                                              orderITEMs_list[index]
                                                  .single_price
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 35,
                                              ),
                                            ),
                                            Text(
                                              orderITEMs_list[index]
                                                  .total_price
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (ctx, index) {
                                  return Divider(
                                    thickness: 2,
                                    color: border_Color,
                                  );
                                },
                              ),
                            ],
                          ),
                  ),
                  Container(
                    height: hieght * 0.50,
                    width: 4,
                    color: border_Color,
                  ),

                  // count handle
                  SizedBox(
                    width: (width / 11) - 4,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: const Icon(Icons.add)),
                            IconButton(
                                onPressed: () {
                                  if (count == 1) return;
                                  setState(() {
                                    count--;
                                  });
                                },
                                icon: const Icon(Icons.remove)),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              count.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 40,
                                color: Color.fromRGBO(10, 13, 21, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ),

                  Container(
                    height: hieght * 0.50,
                    width: 4,
                    color: border_Color,
                  ),
                  //drinks list
                  Flexible(
                    child: ListView.separated(
                      controller: controller1,
                      itemCount: drinks_list.length,
                      itemBuilder: (ctx, index) {
                        return Stack(
                          children: [
                            Positioned(
                              left: (width / 11) - 4,
                              child: Container(
                                color: border_Color,
                                width: 4,
                                height: 50,
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      drinks_list[index].price.toString(),
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (width / 11 * 2) - 4,
                                    child: Center(
                                      child: Text(
                                        drinks_list[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 35,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              onTap: () {
                                if (selected_ORDER_id == null) return;
                                add_order_Items(drinks_list[index]);
                                get_Order_Items(selected_ORDER_id!);
                                setState(() {});
                              },
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          thickness: 2,
                          color: border_Color,
                        );
                      },
                    ),
                  ),

                  Container(
                    height: hieght * 0.50,
                    width: 4,
                    color: border_Color,
                  ),
                  // dviceslist
                  SizedBox(
                    width: (width / 11 * 3) - 2,
                    child: ListView.separated(
                      controller: controller0,
                      itemCount: available_devices.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          color: index == selected_device_index
                              ? Colors.blueGrey
                              : Colors.white,
                          child: ListTile(
                            title: Text(
                              available_devices[index].name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                              ),
                            ),
                            selected: index == selected_device_index,
                            onTap: () {
                              setState(() {
                                selected_device_index = index;
                              });
                              print(selected_device_index);
                            },
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider(
                          thickness: 2,
                          color: border_Color,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: hieght * 0.33,
              //color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // تقفيل الوقت
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            close_time();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: border_Color, width: 4),
                              color: field_Color,
                            ),
                            width: 250,
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.stop,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                Text(
                                  'إيقاف الوقت',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            refresh_Whole_page();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: border_Color, width: 4),
                              color: field_Color,
                            ),
                            width: 250,
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.refresh,
                                  size: 35,
                                  color: Colors.red,
                                ),
                                Text(
                                  'تحديث',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // اغلاق الحساب
                  Container(
                    height: hieght * 0.25,
                    width: 4,
                    color: border_Color,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Radio<int>(
                              value: 0,
                              groupValue: print_radioval,
                              onChanged: (val) {
                                setState(() {
                                  print_radioval = val!;
                                });
                              },
                              activeColor: Colors.white,
                              hoverColor: field_Color,
                              autofocus: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Radio<int>(
                              value: 1,
                              groupValue: print_radioval,
                              onChanged: (val) {
                                setState(() {
                                  print_radioval = val!;
                                });
                              },
                              activeColor: Colors.white,
                              hoverColor: field_Color,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'طباعة',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'بدون طباعة',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            close_Order();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: border_Color, width: 4),
                              color: field_Color,
                            ),
                            width: 200,
                            height: 65,
                            child: const Center(
                              child: Text(
                                'إغلاق الحساب',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // تشغيل الوقت
                  Container(
                    height: hieght * 0.25,
                    width: 4,
                    color: border_Color,
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 0,
                                    groupValue: ps_radioval,
                                    onChanged: (val) {
                                      setState(() {
                                        ps_radioval = val!;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    hoverColor: field_Color,
                                    autofocus: true,
                                  ),
                                  const Text(
                                    'Single',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<int>(
                                    value: 1,
                                    groupValue: ps_radioval,
                                    onChanged: (val) {
                                      setState(() {
                                        ps_radioval = val!;
                                      });
                                    },
                                    activeColor: Colors.white,
                                    hoverColor: field_Color,
                                  ),
                                  const Text(
                                    'Multy',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            open_an_order(
                                available_devices[selected_device_index!]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: border_Color, width: 4),
                              color: field_Color,
                            ),
                            width: 200,
                            height: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.play_arrow,
                                  size: 35,
                                  color: Colors.greenAccent,
                                ),
                                Text(
                                  'تشغيل',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  get_Orders() async {
    await orders_db.get_DB();
    await orders_db.intializeDB();
    await orderItems_DB.get_DB();
    await orderItems_DB.intializeDB();
    await devices_db.get_DB();
    await devices_db.intializeDB();
    await drinks_db.get_DB();
    await drinks_db.intializeDB();
    available_devices = await devices_db.readAllData();
    orders_list = await orders_db.readAllData();
    orders_list.removeWhere((element) => element.isOpened == 0);
    available_devices.removeWhere((element) => element.isActive == 1);
    drinks_list = await drinks_db.readAllData();
    setState(() {});
  }

  open_an_order(Device device) async {
    await devices_db.open_Device(device.id!);
    await orders_db.create_Order(Order(
      name: device.name,
      single: device.price_single,
      multy: device.price_multy,
      device_id: device.id,
      start_time: DateTime.now().toUtc(),
      isMulty: ps_radioval,
      isOpened: 1,
    ));
    showDialog(
        context: context,
        builder: (ctc) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'تم تشغيل الجهاز',
                style: TextStyle(fontSize: 25),
              ),
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(ctc);
                  },
                  child: const Text('OK'),
                ),
              )
            ],
          );
        });
    selected_device_index = null;
    get_Orders();
  }

  get_Order_Items(int fk) async {
    orderITEMs_list = await orderItems_DB.readAllData(fk);
    setState(() {});
    print('l = ' "${orderITEMs_list.length}");
  }

  refresh_Whole_page() {
    selected_device_index = null;
    selected_ORDER_id = null;
    orderITEMs_list = [];
    ps_radioval = 0;
    print_radioval = 0;
    count = 1;
    setState(() {});
  }

  add_order_Items(Drink drink) async {
    if (selected_ORDER_id == null) {
      showDialog(
          context: context,
          builder: (ctc) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'قم بإختيار الجهاز اولا',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctc);
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          });
    } else {
      await orderItems_DB.createItem(Order_Item(
        name: drink.name,
        single_price: drink.price,
        quantity: count,
        total_price: count * drink.price,
        forign_key: selected_ORDER_id!,
      ));
      orderITEMs_list.add(Order_Item(
        name: drink.name,
        single_price: drink.price,
        quantity: count,
        total_price: count * drink.price,
        forign_key: selected_ORDER_id!,
      ));
      setState(() {});
    }
  }

  close_time() async {
    if (selected_ORDER_id == null) {
      showDialog(
          context: context,
          builder: (ctc) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'قم بإختيار الجهاز اولا',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctc);
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          });
    } else {
      print('1');
      Order order =
          orders_list.singleWhere((element) => element.id == selected_ORDER_id);
      var difference = order.start_time.difference(DateTime.now()).inMinutes;
      difference = difference.abs();
      double playSub = order.isMulty! == 1
          ? (difference * (order.multy! / 60)).toDouble()
          : (difference * (order.single! / 60)).toDouble();
      playSub = double.parse(playSub.toStringAsFixed(2));
      await orders_db.close_Order_time(Order(
        id: order.id,
        name: order.name,
        start_time: order.start_time,
        single: order.single,
        multy: order.multy,
        device_id: order.device_id,
        playstation_subtotal: playSub,
        isMulty: order.isMulty,
        isOpened: order.isOpened,
      ));
      orders_list[selected_ORDER_index!] =
          await orders_db.readOrder(selected_ORDER_id!);

      get_Orders();

      setState(() {});

      print('timeended');
    }
  }

  close_Order() async {
    Order order =
        orders_list.singleWhere((element) => element.id == selected_ORDER_id);
    if (selected_ORDER_id == null) {
      showDialog(
          context: context,
          builder: (ctc) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'قم بإختيار الجهاز اولا',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctc);
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          });
      return;
    } else if (order.end_time == null) {
      {
        showDialog(
            context: context,
            builder: (ctc) {
              return AlertDialog(
                title: const Center(
                  child: Text(
                    'الرجاء ايقاف الوقت اولا',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                actions: [
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(ctc);
                      },
                      child: const Text('OK'),
                    ),
                  )
                ],
              );
            });
      }
      return;
    } else {
      Order order =
          orders_list.singleWhere((element) => element.id == selected_ORDER_id);

      var difference = order.start_time.difference(order.end_time!).inMinutes;
      difference = difference.abs();
      double playSub = order.isMulty! == 1
          ? (difference * (order.multy! / 60)).toDouble()
          : (difference * (order.single! / 60)).toDouble();
      playSub = double.parse(playSub.toStringAsFixed(2));
      double drinksSub = 0.0;
      if (orderITEMs_list.isEmpty) {
        drinksSub = 0.0;
      } else {
        for (var i = 0; i < orderITEMs_list.length; i++) {
          drinksSub = drinksSub + orderITEMs_list[i].total_price;
        }
      }

      var total = playSub + drinksSub;
      order = Order(
        id: order.id,
        name: order.name,
        start_time: order.start_time,
        end_time: order.end_time,
        single: order.single,
        multy: order.multy,
        device_id: order.device_id,
        isMulty: order.isMulty,
        isOpened: 0,
        playstation_subtotal: playSub,
        drinks_subtotal: drinksSub,
        total: total,
      );
      await orders_db.close_Order(order);
      await devices_db.close_Device(order.device_id!);
      showDialog(
          context: context,
          builder: (ctc) {
            return AlertDialog(
              title: const Center(
                child: Text(
                  'تم إغلاق الحساب',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              actions: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctc);
                    },
                    child: const Text('OK'),
                  ),
                )
              ],
            );
          });
    }
    if (print_radioval == 0) {
      print_reciept(order, orderITEMs_list);
    }
    selected_ORDER_id = null;
    selected_ORDER_index = null;
    get_Orders();
  }

  print_reciept(Order order, List<Order_Item> items) async {
    print('printing');
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(
          await rootBundle.load("assets/Cairo-VariableFont_wght.ttf")),
      bold: pw.Font.ttf(
          await rootBundle.load("assets/Cairo-VariableFont_wght.ttf")),
      italic: pw.Font.ttf(
          await rootBundle.load("assets/Cairo-VariableFont_wght.ttf")),
      boldItalic: pw.Font.ttf(
          await rootBundle.load("assets/Cairo-VariableFont_wght.ttf")),
    );

    final doc = pw.Document(theme: myTheme);
    ByteData _bytes = await rootBundle.load('assets/logo.png');
    Uint8List logobytes = _bytes.buffer.asUint8List();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a5,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.ListView(
              children: [
                pw.Center(
                    child: pw.Image(
                        pw.RawImage(bytes: logobytes, height: 50, width: 50))),
                pw.Center(
                  child: pw.Text(
                    order.name!,
                    style: pw.TextStyle(
                      fontSize: 35,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'From',
                      textDirection: pw.TextDirection.rtl,
                      style: pw.TextStyle(
                        fontSize: 30,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                    pw.Text(
                      order.start_time.hour <= 10 &&
                              order.start_time.minute < 10
                          ? '0${order.start_time.hour}:'
                              '0${order.start_time.minute}'
                          : order.start_time.hour <= 10 &&
                                  order.start_time.minute > 10
                              ? '0${order.start_time.hour}:'
                                  '${order.start_time.minute}'
                              : order.start_time.hour >= 10 &&
                                      order.start_time.minute < 10
                                  ? '${order.start_time.hour}:'
                                      '0${order.start_time.minute}'
                                  : '${order.start_time.hour}:'
                                      '${order.start_time.minute}',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'To',
                      style: const pw.TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                    pw.Text(
                      order.end_time!.hour <= 10 && order.end_time!.minute < 10
                          ? '0${order.end_time!.hour}:'
                              '0${order.end_time!.minute}'
                          : order.end_time!.hour <= 10 &&
                                  order.end_time!.minute > 10
                              ? '0${order.end_time!.hour}:'
                                  '${order.end_time!.minute}'
                              : order.end_time!.hour >= 10 &&
                                      order.end_time!.minute < 10
                                  ? '${order.end_time!.hour}:'
                                      '0${order.end_time!.minute}'
                                  : '${order.end_time!.hour}:'
                                      '${order.end_time!.minute}',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Subtotal',
                      style: const pw.TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    pw.Text(
                      ':',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                    pw.Text(
                      order.playstation_subtotal.toString() + 'EGP',
                      style: const pw.TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                pw.Divider(
                  thickness: 2,
                ),
                pw.SizedBox(
                  height: 50,
                  child: pw.Stack(
                    children: [
                      pw.Positioned(
                        left: 165,
                        child: pw.Container(
                          height: 50,
                          width: 2,
                        ),
                      ),
                      pw.Positioned(
                        left: 310,
                        child: pw.Container(
                          height: 50,
                          width: 2,
                        ),
                      ),
                      pw.Positioned(
                        right: 130,
                        child: pw.Container(
                          height: 50,
                          width: 2,
                        ),
                      ),
                      pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            "Drink",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          pw.Text(
                            "Count",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          pw.Text(
                            "Price",
                            textAlign: pw.TextAlign.center,
                            textDirection: pw.TextDirection.rtl,
                            style: const pw.TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          pw.Text(
                            "Sum",
                            textAlign: pw.TextAlign.center,
                            textDirection: pw.TextDirection.rtl,
                            style: const pw.TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Divider(
                  thickness: 2,
                ),
                if (items.isNotEmpty)
                  pw.ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (ctx, index) {
                      return pw.Stack(
                        children: [
                          pw.Positioned(
                            left: 165,
                            child: pw.Container(
                              height: 50,
                              width: 2,
                            ),
                          ),
                          pw.Positioned(
                            left: 310,
                            child: pw.Container(
                              height: 50,
                              width: 2,
                            ),
                          ),
                          pw.Positioned(
                            right: 130,
                            child: pw.Container(
                              height: 50,
                              width: 2,
                            ),
                          ),
                          pw.SizedBox(
                            height: 50,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  items[index].name,
                                  textDirection: pw.TextDirection.rtl,
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                                pw.Text(
                                  items[index].quantity.toString(),
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                                pw.Text(
                                  items[index].single_price.toString(),
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                                pw.Text(
                                  items[index].total_price.toString(),
                                  textAlign: pw.TextAlign.center,
                                  style: const pw.TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          pw.Divider(
                            thickness: 2,
                          ),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Subtotal',
                                style: const pw.TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              pw.Text(
                                ':',
                                style: const pw.TextStyle(fontSize: 30),
                              ),
                              pw.Text(
                                order.drinks_subtotal.toString() + 'EGP',
                                style: const pw.TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                          pw.Divider(
                            thickness: 2,
                          ),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Total',
                                style: const pw.TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              pw.Text(
                                '${order.total}' + 'EGP',
                                style: const pw.TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return pw.Divider(
                        thickness: 2,
                      );
                    },
                  ),
              ],
            ),
          ); // Center
        })); // Page

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}
