import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/response/reserveData.dart';
import 'package:puppal_application/navbar/navbar_user.dart';
import 'package:puppal_application/pages_clinic/clinic_search.dart';
import 'package:puppal_application/pages_user/calendar_page.dart';
import 'package:puppal_application/pages_user/login_page.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';
import 'package:puppal_application/pages_user/user_request.dart';

class ClinicRequest extends StatefulWidget {
  const ClinicRequest({super.key});

  @override
  State<ClinicRequest> createState() => _ClinicRequestState();
}

class _ClinicRequestState extends State<ClinicRequest> {
  String url = "";
  int uid = 0;
  int type = 0;
  double screenWidth = 0;
  double screenHeight = 0;

  List<ReserveData> reserveResponse = [];

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
    type = context.read<Appdata>().type;
    getAllRequest();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('คำร้องขอ')),
        backgroundColor: const Color(0xFF8C6C59),
      ),
      endDrawer: Drawer(
        width: 250,
        backgroundColor: const Color(0xFF8C6C59),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: AssetImage('assets/profile.png'),
                  // ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'puppal',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        'รับน้องหมาจร',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            type == 1
                ? ListTile(
                    leading: const Icon(Icons.pets, color: Colors.white),
                    title: const Text(
                      'ค้นหาคลินิก',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.off(() => const ClinicSearch());
                    },
                  )
                : ListTile(
                    leading: const Icon(Icons.pets, color: Colors.white),
                    title: const Text(
                      'คำร้องขอ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(() => const ClinicRequest());
                    },
                  ),
            type == 1
                ? ListTile(
                    leading: const Icon(Icons.vaccines, color: Colors.white),
                    title: const Text(
                      'สถานะการฉีดยา',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(() => const UserRequest());
                    },
                  )
                : const ListTile(
                    leading: Icon(Icons.vaccines, color: Colors.white),
                    title: Text(
                      'ตารางฉีดยา',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            type == 1
                ? ListTile(
                    leading: SvgPicture.string(
                      '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;">
        <path d="M21 6h-2l-1.27-1.27A2.49 2.49 0 0 0 16 4h-2.5A2.64 2.64 0 0 0 11 2v6.36a4.38 4.38 0 0 0 1.13 2.72 6.57 6.57 0 0 0 4.13 1.82l3.45-1.38a3 3 0 0 0 1.73-1.84L22 8.15a1.06 1.06 0 0 0 0-.31V7a1 1 0 0 0-1-1zm-5 2a1 1 0 1 1 1-1 1 1 0 0 1-1 1z"></path>
        <path d="M11.38 11.74A5.24 5.24 0 0 1 10.07 9H6a1.88 1.88 0 0 1-2-2 1 1 0 0 0-2 0 4.69 4.69 0 0 0 .48 2A3.58 3.58 0 0 0 4 10.53V22h3v-5h6v5h3v-8.13a7.35 7.35 0 0 1-4.62-2.13z"></path>
      </svg>''',
                      width: 24,
                      height: 24,
                      color: Colors.white, // Set the color to white
                    ),
                    title: const Text(
                      'สุนัขของฉัน',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(() => const MydogPage());
                    },
                  )
                : ListTile(
                    leading: SvgPicture.string(
                      '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" style="fill: rgba(0, 0, 0, 1);transform: ;msFilter:;">
        <path d="M21 6h-2l-1.27-1.27A2.49 2.49 0 0 0 16 4h-2.5A2.64 2.64 0 0 0 11 2v6.36a4.38 4.38 0 0 0 1.13 2.72 6.57 6.57 0 0 0 4.13 1.82l3.45-1.38a3 3 0 0 0 1.73-1.84L22 8.15a1.06 1.06 0 0 0 0-.31V7a1 1 0 0 0-1-1zm-5 2a1 1 0 1 1 1-1 1 1 0 0 1-1 1z"></path>
        <path d="M11.38 11.74A5.24 5.24 0 0 1 10.07 9H6a1.88 1.88 0 0 1-2-2 1 1 0 0 0-2 0 4.69 4.69 0 0 0 .48 2A3.58 3.58 0 0 0 4 10.53V22h3v-5h6v5h3v-8.13a7.35 7.35 0 0 1-4.62-2.13z"></path>
      </svg>''',
                      width: 24,
                      height: 24,
                      color: Colors.white, // Set the color to white
                    ),
                    title: const Text(
                      'การตั้งค่า',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {},
                  ),
            type == 1
                ? const ListTile(
                    leading: Icon(Icons.announcement, color: Colors.white),
                    title: Text(
                      'ประกาศสุนัขหาย',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListTile(
                    leading: const Icon(Icons.person, color: Colors.white),
                    title: const Text(
                      'สลับไปยังผู้ใช้ทั่วไป',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(
                          () => const ClinicSearch()); //IT CANT ROUTE THE BELOW
                      Get.to(() => NavbarUser(selectedPage: 0)); //THIS ONE SHIT
                      context.read<Appdata>().type = 1;
                    },
                  ),
            type == 1
                ? const ListTile(
                    leading: Icon(Icons.history, color: Colors.white),
                    title: Text(
                      'ประวัติการฉีดยา',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
            type == 1
                ? ListTile(
                    leading:
                        const Icon(Icons.calendar_today, color: Colors.white),
                    title: const Text(
                      'ปฏิทิน',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(() => const CalendarPage());
                    },
                  )
                : const SizedBox.shrink(),
            type == 1
                ? const ListTile(
                    leading: Icon(Icons.menu_book, color: Colors.white),
                    title: Text(
                      'คู่มือการฉีดยาและดูแลสุนัข',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
            type == 1
                ? const ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text(
                      'การตั้งค่า',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : const SizedBox.shrink(),
            type == 1
                ? ListTile(
                    leading: const Icon(Icons.healing, color: Colors.white),
                    title: const Text(
                      'สลับไปยังคลินิก',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(
                          () => const ClinicSearch()); //IT CANT ROUTE THE BELOW
                      Get.to(() => NavbarUser(selectedPage: 0)); //THIS ONE SHIT
                      context.read<Appdata>().type = 2;
                    },
                  )
                : const SizedBox.shrink(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text(
                'ออกจากระบบ',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Get.to(() => const LoginPage()); //IT CANT ROUTE THE BELOW
              },
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: reserveResponse.length, // Length of your list
                  itemBuilder: (context, index) {
                    var book = reserveResponse[
                        index]; // Get the current item in the list

                    return Card(
                      color: const Color(0xFFD9D9D9),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 250, 106, 106),
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text(
                                    'รอการยืนยัน',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.1,
                                    ),
                                    Text(book.ownername), // Use dynamic data
                                  ],
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.09,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("ID: ${book.dRid}"),
                                        Text("ชื่อ: ${book.dogname}"),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      showConfirmationDialog(context, book.rid);
                                    },
                                    child: const Text('ยืนยัน')),
                                ElevatedButton(
                                    onPressed: () {
                                      showCancelDialog(context, book.rid);
                                    },
                                    child: const Text('ยกเลิก')),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void showConfirmationDialog(BuildContext context, int rid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ยืนยันคำร้องขอ?"),
          content: const Text("คุณต้องการรับคำขอของผู้ใช้นี้?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    await confirmRequest(
                        rid); // Call the cancelRequest function
                    // Optionally, show a success message or perform other actions
                  },
                  child: const Text("ใช่"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("ไม่"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showCancelDialog(BuildContext context, int rid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("ยกเลิกคำขอจอง"),
          content:
              const Text("คุณต้องการยกเลิกคำขอนี้? คุณไม่สามารถกู้คืนได้!"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(); // Close the dialog
                    await cancleRequest(rid); // Call the cancelRequest function
                    // Optionally, show a success message or perform other actions
                  },
                  child: const Text("ใช่"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("ไม่"),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmRequest(int rid) async {
    showLoadingDialog(context, true);
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.put(
      Uri.parse("$url/reserve/accept/$rid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    log(response.body);
    getAllRequest();
    Get.back();
  }

  Future<void> cancleRequest(int rid) async {
    showLoadingDialog(context, true);
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.put(
      Uri.parse("$url/reserve/cancle/$rid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );
    log(response.body);
    getAllRequest();
    Get.back();
  }

  Future<void> getAllRequest() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/reserve/$uid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    log('Registration response: ${response.body}');
    var decode = jsonDecode(response.body);
    reserveResponse = (decode as List)
        .map((jsonitem) => ReserveData.fromJson(jsonitem))
        .toList();

    // log("length DOG:${dogResponse.length}");
    reserveResponse.forEach((book) {
      log(book.dogname);
    });
    setState(() {});
  }

  void showLoadingDialog(BuildContext context, bool isLoading) {
    if (!isLoading) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                      strokeWidth: 10,
                    ),
                  ),
                  SizedBox(height: 20), // Space between the indicator and text
                  Text(
                    "กำลังโหลด...",
                    style: TextStyle(color: Colors.white),
                  ), // Optional loading text
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
