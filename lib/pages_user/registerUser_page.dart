import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/models/request/user_register.dart';
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
  String url = "";

  late UserRegister userRegisterReq;
  TextEditingController nameCtl = TextEditingController();
  TextEditingController surnameCtl = TextEditingController();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextEditingController confirmpasswordCtl = TextEditingController();

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
                          controller: usernameCtl,
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
                          controller: nameCtl,
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
                          controller: surnameCtl,
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
                          controller: emailCtl,
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
                          controller: phoneCtl,
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
                          controller: passwordCtl,
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
                          controller: confirmpasswordCtl,
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
    if (usernameCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(usernameCtl.text)) {
      showErrorDialog('กรุณากรอกชื่อผู้ใช้'); // "Please enter your name"
      return;
    }

    if (nameCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(nameCtl.text)) {
      showErrorDialog('กรุณากรอกชื่อ'); // "Please enter your name"
      return;
    }

    if (surnameCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(surnameCtl.text)) {
      showErrorDialog('กรุณากรอกนามสกุล'); // "Please enter your name"
      return;
    }

    if (emailCtl.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(emailCtl.text)) {
      showErrorDialog('กรุณากรอกนามอีเมลให้ถูกต้อง');
      return;
    }

    if (phoneCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(phoneCtl.text) ||
        !RegExp(r'^\d+$').hasMatch(phoneCtl.text)) {
      showErrorDialog(
          'กรุณากรอกหมายเลขโทรศัพท์'); // "Please enter your phone number"
      return;
    }

    if (phoneCtl.text.length != 10) {
      showErrorDialog(
          'หมายเลขโทรศัพท์ต้องมี 10 หลัก'); // "Phone number must be 10 digits"
      return;
    }

    if (passwordCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(passwordCtl.text)) {
      showErrorDialog('กรุณากรอกรหัสผ่าน'); // "Please enter your password"
      return;
    }

    if (confirmpasswordCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(confirmpasswordCtl.text)) {
      showErrorDialog(
          'กรุณากรอกรหัสผ่านอีกครั้ง'); // "Please confirm your password"
      return;
    }

    if (passwordCtl.text != confirmpasswordCtl.text) {
      showErrorDialog('รหัสผ่านไม่ตรงกัน'); // "Passwords do not match"
      return;
    }
    Get.to(() => Registerclinicmap(
          userData: userRegisterReq = UserRegister(
            email: emailCtl.text,
            username: usernameCtl.text,
            phone: phoneCtl.text,
            password: passwordCtl.text,
            nameSurname: "${nameCtl.text} ${surnameCtl.text}",
            profilePic: "FIREBASE DEAD!",
            type: 1,
          ),
        ));
  }

  Future<void> userRegisterButton() async {
    if (usernameCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(usernameCtl.text)) {
      showErrorDialog('กรุณากรอกชื่อผู้ใช้'); // "Please enter your name"
      return;
    }

    if (nameCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(nameCtl.text)) {
      showErrorDialog('กรุณากรอกชื่อ'); // "Please enter your name"
      return;
    }

    if (surnameCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(surnameCtl.text)) {
      showErrorDialog('กรุณากรอกนามสกุล'); // "Please enter your name"
      return;
    }

    if (emailCtl.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
            .hasMatch(emailCtl.text)) {
      showErrorDialog('กรุณากรอกนามอีเมลให้ถูกต้อง');
      return;
    }

    if (phoneCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(phoneCtl.text) ||
        !RegExp(r'^\d+$').hasMatch(phoneCtl.text)) {
      showErrorDialog(
          'กรุณากรอกหมายเลขโทรศัพท์'); // "Please enter your phone number"
      return;
    }

    if (phoneCtl.text.length != 10) {
      showErrorDialog(
          'หมายเลขโทรศัพท์ต้องมี 10 หลัก'); // "Phone number must be 10 digits"
      return;
    }

    if (passwordCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(passwordCtl.text)) {
      showErrorDialog('กรุณากรอกรหัสผ่าน'); // "Please enter your password"
      return;
    }

    if (confirmpasswordCtl.text.isEmpty ||
        RegExp(r'^\s+$').hasMatch(confirmpasswordCtl.text)) {
      showErrorDialog(
          'กรุณากรอกรหัสผ่านอีกครั้ง'); // "Please confirm your password"
      return;
    }

    if (passwordCtl.text != confirmpasswordCtl.text) {
      showErrorDialog('รหัสผ่านไม่ตรงกัน'); // "Passwords do not match"
      return;
    }

    // ถ้าข้อมูลครบถ้วน สามารถดำเนินการอัพโหลดและบันทึกข้อมูลต่อไปได้
    showLoadingDialog(context, true);
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndPoint'];
      log(url);
      log("${nameCtl.text} ${surnameCtl.text}");

      UserRegister userRegisterReq = UserRegister(
        email: emailCtl.text,
        username: usernameCtl.text,
        phone: phoneCtl.text,
        password: passwordCtl.text,
        nameSurname: "${nameCtl.text} ${surnameCtl.text}",
        profilePic: "FIREBASE DEAD!",
        type: 1,
      );

      final response = await http.post(
        Uri.parse("$url/user/register"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode(userRegisterReq.toJson()),
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
                          "สมัครสมาชิกสำเร็จ!", // "Success"
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
                        "ยินดีต้อนรับสู่ระบบขนส่ง HERMES ครับ", // "Item sent successfully"
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
                                Get.to(() => const LoginPage());
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
                          "สมัครสมาชิกไม่สำเร็จ", // "Success"
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
                        "เบอร์นี้ถูกใช้แล้ว", // "Item sent successfully"
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
    } catch (error) {
      log('Error during registration: $error');
      showErrorDialog(
          'เกิดข้อผิดพลาดระหว่างการลงทะเบียน'); // "Error during registration"
    }
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
