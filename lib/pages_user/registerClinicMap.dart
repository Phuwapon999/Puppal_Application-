import 'package:flutter/material.dart';

class Registerclinicmap extends StatefulWidget {
  const Registerclinicmap({super.key});

  @override
  State<Registerclinicmap> createState() => _RegisterclinicmapState();
}

class _RegisterclinicmapState extends State<Registerclinicmap> {
  double screenWidth = 0;
  double screenHeight = 0;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(screenWidth * 0.45, screenHeight * 0.06),
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
          )
        ],
      ),
    );
  }
}
