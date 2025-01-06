import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/response/dogData.dart';
import 'package:puppal_application/pages_clinic/clinic_search.dart';
import 'package:puppal_application/pages_user/registerDog_page.dart';

class MydogPage extends StatefulWidget {
  const MydogPage({super.key});

  @override
  State<MydogPage> createState() => _MydogPageState();
}

class _MydogPageState extends State<MydogPage> {
  int uid = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  String url = "";

  List<DogData> dogResponse = [];

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
    getAllDog();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('สุนัขของฉัน')),
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
              ListTile(
                leading: const Icon(Icons.pets, color: Colors.white),
                title: const Text(
                  'ค้นหาคลินิก',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Get.to(() => const ClinicSearch());
                },
              ),
              const ListTile(
                leading:
                    Icon(Icons.vaccines, color: Color.fromARGB(255, 22, 6, 6)),
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
                onTap: () {
                  Get.to(() => const MydogPage());
                },
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dogResponse.length + 1, // Length of your list
                itemBuilder: (context, index) {
                  if (index < dogResponse.length) {
                    var dog =
                        dogResponse[index]; // Get the current item in the list

                    return Card(
                      color: const Color(0xFFD9D9D9),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0, screenWidth * 0.15, 0),
                                child: Text(
                                    "ID: ${dog.did.toString()}")), // Use dynamic data
                            Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: screenWidth * 0.125,
                                    ),
                                    Text(dog.name), // Use dynamic data
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth * 0.1,
                                      0,
                                      0,
                                      screenHeight * 0.05),
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "พันธุ์: ${dog.breed}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text("วันเกิด: ${dog.birth}",
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                          Text("เพศ: ${dog.gender}",
                                              style: const TextStyle(
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const RegisterdogPage());
                      },
                      child: SizedBox(
                        height: screenHeight * 0.15,
                        child: Card(
                          color: const Color(0xFFD9D9D9),
                          elevation: 5,
                          child: Column(
                            children: [
                              Icon(
                                Icons.add,
                                size: screenWidth * 0.2,
                              ),
                              const Text('ลงทะเบียนสุนัขเพิ่ม')
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  ;
                },
              ),
            ),
          ],
        ));
  }

  Future<void> getAllDog() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/dog/$uid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    log('Registration response: ${response.body}');
    var decode = jsonDecode(response.body);
    dogResponse =
        (decode as List).map((jsonitem) => DogData.fromJson(jsonitem)).toList();

    // log("length DOG:${dogResponse.length}");
    // dogResponse.forEach((dog) {
    //   log(dog.did.toString());
    // });
    setState(() {});
  }
}
