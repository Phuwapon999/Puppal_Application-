import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/request/reserve_data.dart';
import 'package:puppal_application/models/response/dogData.dart';
import 'package:table_calendar/table_calendar.dart';

class BookPage extends StatefulWidget {
  int did;
  BookPage({super.key, required this.did});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  int uid = 0;
  int did = 0;
  double screenWidth = 0;
  double screenHeight = 0;
  String url = "";

  String? _selectedDog;
  TextEditingController didCtl = TextEditingController();
  TextEditingController dogShow = TextEditingController();
  List<DogData> dogResponse = [];

  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    uid = context.read<Appdata>().uid;
    did = widget.did;
    getAllDog();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
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
          ),
          Text(DateFormat('dd MMMM yyyy', 'th').format(DateTime(
              _selectedDay.year + 543, _selectedDay.month, _selectedDay.day))),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'เลือกสุนัขที่จะจองฉีด',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth * 0.4,
                  child: TextField(
                    controller: dogShow,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'เลือกสุนัขของคุณ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      floatingLabelBehavior: dogShow.text.isEmpty
                          ? FloatingLabelBehavior.auto
                          : FloatingLabelBehavior.never,
                    ),
                    onTap: () {
                      showDropdownDialogDogSelect(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(onPressed: confirmDate, child: const Text('ยืนยัน'))
        ],
      ),
    );
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

  void showDropdownDialogDogSelect(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เลือกสุนัขของคุณ'),
          content: SizedBox(
            width: screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: dogResponse.map((DogData dog) {
                  return ListTile(
                    title: Text(dog.name, style: const TextStyle(fontSize: 18)),
                    onTap: () {
                      setState(() {
                        _selectedDog = dog.did.toString();
                        didCtl.text = dog.did.toString();
                        dogShow.text = dog.name; // Set the selected breed
                        log(didCtl.text);
                      });
                      Navigator.pop(context); // Close the dialog
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> confirmDate() async {
    showLoadingDialog(context, true);
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    ReserveInput reserveData = ReserveInput(
        uRid: uid,
        docRid: did,
        dRid: int.parse(didCtl.text),
        date: _selectedDay);

    final response = await http.post(
      Uri.parse("$url/reserve/add"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: json.encode(reserveData.toJson()),
    );

    log('Registration response: ${response.body}');
    Navigator.of(context).pop();
    if (response.statusCode == 200) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 10, 10),
                    child: Center(
                      child: Text(
                        "ส่งคำร้องขอแล้ว", // "Success"
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "กรุณารอคุณหมอตอบรับคำร้องของคุณ", // "Item sent successfully"
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.06,
                          child: FilledButton(
                            onPressed: () {
                              // Get.to(() => const LoginPage());
                              Get.back();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFFF7723)), // สีพื้นหลัง
                            ),
                            child: const Text(
                              'ตกลง',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white, // เปลี่ยนสีข้อความให้เหมาะสมกับพื้นหลัง
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 25, 10, 10),
                    child: Center(
                      child: Text(
                        "ไม่สามารถจองได้", // "Success"
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ไม่สามารถจองได้", // "Item sent successfully"
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.06,
                          child: FilledButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFFF7723)), // สีพื้นหลัง
                            ),
                            child: const Text(
                              'ตกลง',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white, // เปลี่ยนสีข้อความให้เหมาะสมกับพื้นหลัง
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
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

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 10, 10),
                  child: Center(
                    child: Text(
                      "เกิดข้อผิดพลาด!", // "Error"
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    message, // แสดงข้อความข้อผิดพลาด
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xFFFF7723)), // สีพื้นหลัง
                          ),
                          child: const Text(
                            'ตกลง',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
