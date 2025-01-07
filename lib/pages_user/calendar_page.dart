import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/response/reserveDataUser.dart';
import 'package:puppal_application/pages_clinic/clinic_request.dart';
import 'package:puppal_application/pages_clinic/clinic_search.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';
import 'package:puppal_application/pages_user/user_request.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  int uid = 0;
  int type = 0;
  String url = "";

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<ReserveDataUser> reserveUser = [];

  Map<DateTime, List<ReserveDataUser>> events = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    uid = context.read<Appdata>().uid;
    type = context.read<Appdata>().type;

    getAllRequest();
  }

  @override
  Widget build(BuildContext context) {
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
            type == 1
                ? ListTile(
                    leading: const Icon(Icons.pets, color: Colors.white),
                    title: const Text(
                      'ค้นหาคลินิก',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(() => const ClinicSearch());
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
                : const SizedBox.shrink(),
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
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            locale: 'th_TH',
            focusedDay: _focusedDay,
            firstDay: DateTime.now(),
            lastDay: DateTime(DateTime.now().year + 1, 1, 0),
            calendarFormat: _calendarFormat,
            onDaySelected: (selectedDay, focusedDay) {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              setState(() {});
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                    color: Colors.orange, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.orange,
                    width: 2.0,
                  ),
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.black)),
            eventLoader: (day) {
              return events[day] ?? [];
            },
          ),
          Text(DateFormat('dd MMMM yyyy', 'th').format(DateTime(
              _selectedDay.year + 543, _selectedDay.month, _selectedDay.day))),
        ],
      ),
    );
  }

  Future<void> getAllRequest() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/reserve/user/calendar/$uid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    log('Registration response: ${response.body}');
    var decode = jsonDecode(response.body);
    reserveUser = (decode as List)
        .map((jsonitem) => ReserveDataUser.fromJson(jsonitem))
        .toList();

    // log("length DOG:${dogResponse.length}");
    reserveUser.forEach((book) {
      log(book.clinicname);
    });

    events.clear();
    for (var reserve in reserveUser) {
      DateTime eventDate = DateTime.parse(reserve.date);
      if (events[eventDate] == null) {
        events[eventDate] = [];
      }
      events[eventDate]?.add(reserve);
    }
    log("Number of events: ${events.length}");
    setState(() {});
  }
}
