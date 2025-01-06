import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Color _circleColor = Colors.grey; // สีเริ่มต้นของวงกลม
  Widget build(BuildContext context) {
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
            const ListTile(
              leading: Icon(Icons.pets, color: Colors.white),
              title: Text(
                'ค้นหาคลินิก',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.vaccines, color: Colors.white),
              title: Text(
                'สถานะการฉีดยา',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
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
            ),
            const ListTile(
              leading: Icon(Icons.announcement, color: Colors.white),
              title: Text(
                'ประกาศสุนัขหาย',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.history, color: Colors.white),
              title: Text(
                'ประวัติการฉีดยา',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.white),
              title: Text(
                'ปฏิทิน',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.menu_book, color: Colors.white),
              title: Text(
                'คู่มือการฉีดยาและดูแลสุนัข',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text(
                'การตั้งค่า',
                style: TextStyle(color: Colors.white),
              ),
            ),
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
              child: Column(
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
                          child: profileInfoItem('9999 ล้าน', 'ผู้ติดตาม'),
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
                        child: Column(
                          children: [
                            Text(
                              'Puppal',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'keyword',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 0, 0, 30),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5B61A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'แก้ไขโปรไฟล์',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'สุนัขของฉัน',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 75,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // เปลี่ยนสีเมื่อกด
                          _circleColor = _circleColor == Colors.grey
                              ? Color(0xFFF5B61A)
                              : Colors.grey;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center, // จัดให้ไอคอนอยู่ตรงกลาง
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: _circleColor, // ใช้สีที่เปลี่ยนไป
                          ),
                          const Icon(
                            Icons.add, // ไอคอนบวก
                            size: 40,
                            color: Colors.white, // สีของไอคอน
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Divider(),
          ],
        ),
      ),
    );
  }

  // Function: Drawer Menu Items
  static ListTile drawerMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }

  // Function: Profile Info Items
  Widget profileInfoItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // Function: Pet Circle Avatars
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
