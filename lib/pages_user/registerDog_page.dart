import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/request/dog_register.dart';
import 'package:puppal_application/models/response/breedData.dart';
import 'package:puppal_application/pages_user/myDog_page.dart';

class RegisterdogPage extends StatefulWidget {
  const RegisterdogPage({super.key});

  @override
  State<RegisterdogPage> createState() => _RegisterdogPageState();
}

class _RegisterdogPageState extends State<RegisterdogPage> {
  int uid = 0;
  int breedID = 0;
  int sterilization = 0;
  String url = "";
  double screenWidth = 0;
  double screenHeight = 0;

  List<BreedData> breedResponse = [];

  String? _selectedBreed;
  TextEditingController breedShow = TextEditingController();

  String selectedGender = "ชาย";
  int? selectedSterilization;

  TextEditingController nameCtl = TextEditingController();
  TextEditingController breedCtl = TextEditingController();
  TextEditingController birthCtl = TextEditingController();
  TextEditingController colorCtl = TextEditingController();
  TextEditingController defectCtl = TextEditingController();
  TextEditingController genderCtl = TextEditingController();
  TextEditingController conDiseaseCtl = TextEditingController();
  TextEditingController vacHistoryCtl = TextEditingController();
  TextEditingController sterilizationCtl = TextEditingController();
  TextEditingController picCtl = TextEditingController();
  TextEditingController hairCtl = TextEditingController();
  TextEditingController statusCtl = TextEditingController();

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
    getBreed();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    breedResponse.sort((a, b) => a.name.compareTo(b.name));
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ลงทะเบียนสุนัข')),
        backgroundColor: const Color(0xFF8C6C59),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              0, screenHeight * 0.02, 0, screenHeight * 0.075),
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
                        const Text('ชื่อสุนัข',
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
                        const Text('พันธุ์',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: breedShow,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'เลือกพันธุ์สุนัข',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            floatingLabelBehavior: breedShow.text.isEmpty
                                ? FloatingLabelBehavior.auto
                                : FloatingLabelBehavior.never,
                          ),
                          onTap: () {
                            showDropdownDialog(context);
                          },
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
                        const Text('วันเกิด',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: birthCtl,
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
                        const Text('สีตัว',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: colorCtl,
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
                        const Text('เพศ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: selectedGender == 'ชาย',
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedGender = value!
                                          ? 'ชาย'
                                          : 'หญิง'; // Select 'ชาย' or null
                                    });
                                  },
                                ),
                                const Text('ชาย'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: selectedGender == 'หญิง',
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedGender = value!
                                          ? 'หญิง'
                                          : 'ชาย'; // Select 'หญิง' or null
                                    });
                                  },
                                ),
                                const Text('หญิง'),
                              ],
                            ),
                          ],
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
                        const Text('ตำหนิ(ถ้ามี)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: defectCtl,
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
                        const Text('โรคประจำตัว(ถ้ามี)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: conDiseaseCtl,
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
                        const Text('ประวัติการฉีดยา(ถ้ามี)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: vacHistoryCtl,
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
                        const Text('การทำหมัน(ถ้ามี)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: selectedSterilization == 1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedSterilization = value!
                                          ? 1
                                          : null; // Select 'ชาย' or null
                                    });
                                  },
                                ),
                                const Text('ใช่'),
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: selectedSterilization == 0,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      selectedSterilization = value!
                                          ? 0
                                          : null; // Select 'หญิง' or null
                                    });
                                  },
                                ),
                                const Text('ไม่'),
                              ],
                            ),
                          ],
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
                        const Text('ลักษณะขน(ถ้ามี)',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                        TextField(
                          controller: hairCtl,
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                child: SizedBox(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.075,
                    child: ElevatedButton(
                        onPressed: dogRegister,
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
                        child: const Text('ลงทะเบียนสุนัข',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)))),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getBreed() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/dog/breed"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    var decode = jsonDecode(response.body);
    breedResponse = (decode as List)
        .map((jsonitem) => BreedData.fromJson(jsonitem))
        .toList();

    setState(() {});
  }

  Future<void> dogRegister() async {
    if (nameCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(nameCtl.text)) {
      showErrorDialog('กรุณากรอกชื่อ'); // "Please enter your name"
      return;
    }
    if (birthCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(nameCtl.text)) {
      showErrorDialog('กรุณากรอกวันเกิด'); // "Please enter your name"
      return;
    }
    if (colorCtl.text.isEmpty || RegExp(r'^\s+$').hasMatch(nameCtl.text)) {
      showErrorDialog('กรุณากรอกสีของสุนัข'); // "Please enter your name"
      return;
    }

    // ถ้าข้อมูลครบถ้วน สามารถดำเนินการอัพโหลดและบันทึกข้อมูลต่อไปได้
    showLoadingDialog(context, true);
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndPoint'];
      log(url);

      DogRegister dogRegisterReq = DogRegister(
          bDid: int.parse(breedCtl.text),
          uDid: uid,
          name: nameCtl.text,
          gender: selectedGender!,
          color: colorCtl.text,
          defect: defectCtl.text,
          birth: birthCtl.text,
          conDisease: conDiseaseCtl.text,
          vacHistory: vacHistoryCtl.text,
          sterilization: selectedSterilization,
          pic: "FIREBASE DEAD!",
          hair: hairCtl.text,
          status: 1);

      final response = await http.post(
        Uri.parse("$url/dog/register"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: json.encode(dogRegisterReq.toJson()),
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
                          "ลงทะเบียนสุนัขสำเร็จ!", // "Success"
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
                        "คุณได้ลงทะเบียนให้กับสุนัขแล้ว", // "Item sent successfully"
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
                                Get.to(() => const MydogPage());
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
                          "ไม่สามารถลงทะเบียนได้", // "Success"
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
                        "ไม่สามารถลงทะเบียนได้", // "Item sent successfully"
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
                                // Get.back();
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

  void showDropdownDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เลือกพันธุ์สุนัข'),
          content: SizedBox(
            width: screenWidth,
            child: SingleChildScrollView(
              child: Column(
                children: breedResponse.map((BreedData breed) {
                  return ListTile(
                    title:
                        Text(breed.name, style: const TextStyle(fontSize: 18)),
                    onTap: () {
                      setState(() {
                        _selectedBreed = breed.bid.toString();
                        breedCtl.text = breed.bid.toString();
                        breedShow.text = breed.name; // Set the selected breed
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
}
