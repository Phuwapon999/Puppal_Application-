import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/models/request/clinic_register.dart';
import 'package:puppal_application/models/request/user_register.dart';
import 'package:puppal_application/pages_user/login_page.dart';

class Registerclinicmap extends StatefulWidget {
  final UserRegister userData;

  const Registerclinicmap({super.key, required this.userData});

  @override
  State<Registerclinicmap> createState() => _RegisterclinicmapState();
}

class _RegisterclinicmapState extends State<Registerclinicmap> {
  late UserRegister userData;
  String url = "";
  bool _isLoading = true;
  double screenWidth = 0;
  double screenHeight = 0;
  LatLng? currentLocation;

  Marker? markerTapLocation;
  LatLng? tapLocation;

  CameraPosition initPosition = const CameraPosition(
    target: LatLng(16.246671218679253, 103.25207957788868),
    zoom: 17,
  );

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: initPosition,
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      markers:
                          markerTapLocation != null ? {markerTapLocation!} : {},
                      onTap: (LatLng latlng) {
                        tapLocation = latlng;
                        final newMarker = Marker(
                            markerId: const MarkerId('marker1'),
                            position: latlng,
                            infoWindow: InfoWindow(
                                title: 'Tapped Locaiton',
                                snippet:
                                    'Lat: ${latlng.latitude}, Lng: ${latlng.longitude}'));

                        setState(() {
                          markerTapLocation = newMarker;
                        });
                        log('${latlng.latitude}, ${latlng.longitude}');
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: registerButton,
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void registerButton() async {
    showLoadingDialog(context, true);
    try {
      var config = await Configuration.getConfig();
      url = config['apiEndPoint'];

      ClinicRegister userRegisterReq = ClinicRegister(
        email: userData.email,
        username: userData.username,
        phone: userData.phone,
        password: userData.password,
        nameSurname: userData.nameSurname,
        profilePic: "FIREBASE DEAD!",
        lat: tapLocation!.latitude.toString(),
        lng: tapLocation!.longitude.toString(),
        type: 2,
      );

      final response = await http.post(
        Uri.parse("$url/clinic/register"),
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

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      _isLoading = false;
    });
  }
}
