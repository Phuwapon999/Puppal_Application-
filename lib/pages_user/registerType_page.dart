import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puppal_application/pages_user/registerUser_page.dart';

class RegistertypePage extends StatefulWidget {
  const RegistertypePage({super.key});

  @override
  State<RegistertypePage> createState() => _RegistertypePageState();
}

class _RegistertypePageState extends State<RegistertypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('เลือกประเภทผู้ใช้')),
        backgroundColor: const Color(0xFF8C6C59),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => RegisteruserPage(idx: 1));
                },
                child: Card(
                  color: const Color(0xFFFFECB3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Image.asset('assets/images/userType.png'),
                        const Text(
                          'เจ้าของสุนัข',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                          child: Text(
                            'สมัครเข้าใช้งานพื่อ แชร์สุนัขของคุณกับผู้ใช้คนอื่นๆ ค้นหาคลินิคใกล้คุณ และทำการจองวันฉีดวัคซีน',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => RegisteruserPage(idx: 2));
                },
                child: Card(
                  color: const Color(0xFFFFECB3),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Image.asset('assets/images/clinicType.png'),
                        const Text(
                          'สัตว์แพทย์',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                          child: Text(
                            'สมัครเข้าใช้งานเพื่อ แชร์คลินิคของ ท่านให้กับเจ้าของสุนัข และทำการรับการขอจองวันฉีดวัคซีนจากผู้ใช้',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
