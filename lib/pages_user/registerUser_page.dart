import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppal_application/pages_user/login_page.dart';
import 'package:puppal_application/pages_user/registerClinicMap.dart';

class RegisteruserPage extends StatefulWidget {
  int idx = 0;
  RegisteruserPage({super.key, required this.idx});

  @override
  State<RegisteruserPage> createState() => _RegisteruserPageState();
}

class _RegisteruserPageState extends State<RegisteruserPage> {
  bool _isCheckRule = false;
  double screenWidth = 0;
  double screenHeight = 0;
  int idx = 0;

  @override
  void initState() {
    idx = widget.idx;
    log(widget.idx.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('สมัครเข้าสู่ระบบ')),
        backgroundColor: const Color(0xFF8C6C59),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ชื่อผู้ใช้',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ชื่อ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('นามสกุล',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('อีเมล',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('เบอร์โทรศัพท์',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('รหัสผ่าน',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.05,
                        screenHeight * 0.007,
                        screenWidth * 0.05,
                        screenHeight * 0.007),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ยืนยันรหัสผ่าน',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          decoration: InputDecoration(
                            labelText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _isCheckRule,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isCheckRule = newValue ?? false;
                        // log(_isCheckRule.toString());
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'ยอมรับ ทำตามกฎของแอปพลิเคชันการและแจ้งเตือนของแอปพลิเคชัน',
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, screenHeight * 0.03, 0, screenHeight * 0.1),
                child: idx == 1
                    ? ElevatedButton(
                        onPressed: () {
                          userRegisterButton();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(screenWidth * 0.45, screenHeight * 0.06),
                            backgroundColor: const Color(0xFFFFB300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.black, // Border color
                                width: 1.5, // Border width
                              ),
                            )),
                        child: const Text(
                          'สมัครสมาชิก',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          clinicRegisterButton();
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(screenWidth * 0.45, screenHeight * 0.06),
                            backgroundColor: const Color(0xFFFFB300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: const BorderSide(
                                color: Colors.black, // Border color
                                width: 1.5, // Border width
                              ),
                            )),
                        child: const Text(
                          'ต่อไป',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clinicRegisterButton() {
    Get.to(() => const Registerclinicmap());
  }

  void userRegisterButton() {
    Get.to(() => const LoginPage());
  }
}
