import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/navbar/navbar_user.dart';
import 'package:puppal_application/pages_clinic/clinic_request.dart';
import 'package:puppal_application/pages_clinic/clinic_search.dart';
import 'package:puppal_application/pages_user/calendar_page.dart';
import 'package:puppal_application/pages_user/login_page.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';
import 'package:puppal_application/pages_user/user_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int uid = 0;
  int type = 0;

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
    type = context.read<Appdata>().type;
    log(type.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(child: Text('Puppal')),
        ),
        backgroundColor: Colors.white,
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
      body: const Center(
        child: Text(
          'Welcome to the Home Page',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
