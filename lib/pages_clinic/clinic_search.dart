import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/request/clinic_search.dart';
import 'package:puppal_application/pages_clinic/clinic_page.dart';

class ClinicSearch extends StatefulWidget {
  const ClinicSearch({super.key});

  @override
  State<ClinicSearch> createState() => _ClinicSearchState();
}

class _ClinicSearchState extends State<ClinicSearch> {
  String url = "";
  int uid = 0;
  double screenWidth = 0;
  double screenHeight = 0;

  TextEditingController searchWord = TextEditingController();

  List<SearchClinic> searchData = [];

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ค้นหา",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 45,
                child: TextField(
                  controller: searchWord,
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                    searchClinic();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFECECEC),
                    labelText: '',
                    labelStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD2D2D2),
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD2D2D2),
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        color: Color(0xFFD2D2D2),
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: searchData.length,
                    itemBuilder: (context, index) {
                      var clinic = searchData[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.005),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => ClinicPage(
                                    email: clinic.email,
                                  ));
                            },
                            child: Card(
                              elevation: 4,
                              color: const Color(0xFFD9D9D9),
                              child: SizedBox(
                                width: screenWidth * 0.9,
                                height: screenHeight * 0.15,
                                child: Center(
                                  child: Text(
                                    clinic
                                        .clinicname, // Display clinic name or other property
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }

  Future<void> searchClinic() async {
    var config = await Configuration.getConfig();
    url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/clinic/search/${searchWord.text}/$uid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    log('Registration response: ${response.body}');
    final List<dynamic> responseData = json.decode(response.body);

    searchData =
        responseData.map((data) => SearchClinic.fromJson(data)).toList();

    log('LENGTH: ${searchData.length}');
    setState(() {});
  }
}
