import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/response/userData.dart';
import 'package:puppal_application/navbar/navbar_user.dart';
import 'package:puppal_application/pages_clinic/clinic_request.dart';
import 'package:puppal_application/pages_clinic/clinic_search.dart';
import 'package:puppal_application/pages_user/book_page.dart';
import 'package:puppal_application/pages_user/calendar_page.dart';
import 'package:puppal_application/pages_user/login_page.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';
import 'package:puppal_application/pages_user/user_request.dart';

class ClinicPage extends StatefulWidget {
  String email;
  ClinicPage({super.key, required this.email});

  @override
  State<ClinicPage> createState() => _ClinicPageState();
}

class _ClinicPageState extends State<ClinicPage> {
  int uid = 0;
  int type = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  String url = "";

  String email = "";
  bool isLoadingData = true;
  late UserData accountData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = widget.email;
    uid = context.read<Appdata>().uid;
    type = context.read<Appdata>().type;
    getAccountData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: Profile Information
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: isLoadingData
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, screenHeight * 0.3, 0, 0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 50),
                                child:
                                    profileInfoItem('9999 ล้าน', 'ผู้ติดตาม'),
                              ),
                              const SizedBox(width: 20),
                              profileInfoItem('2', 'กำลังติดตาม'),
                            ],
                          ),
                        ),
                        // ส่วนที่มีรูปภาพโปรไฟล์ และข้อมูลโปรไฟล์
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.225,
                                    child: Center(
                                      child: Text(
                                        accountData.clinicname,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'keyword',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(80, 0, 0, 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFF5B61A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        Get.to(() => BookPage(
                                              did: accountData.uid,
                                            ));
                                      },
                                      child: const Text(
                                        'จองวันฉีด',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.35,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFF5B61A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'ดูที่อยู่',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
    ;
  }

  Future<void> getAccountData() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/user/$email"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    var decode = jsonDecode(response.body);
    var jsondecode = decode[0];
    accountData = UserData.fromJson(jsondecode);
    log(accountData.uid.toString());

    isLoadingData = false;
    setState(() {});
  }

  Widget profileInfoItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget petCircleAvatar(String assetPath, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(assetPath),
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
