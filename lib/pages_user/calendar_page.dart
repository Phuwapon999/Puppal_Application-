import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:puppal_application/config/config.dart';
import 'package:puppal_application/config/share/app_data.dart';
import 'package:puppal_application/models/response/reserveDataUser.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late Map<DateTime, List<String>> _events;
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  int uid = 0;

  List<ReserveDataUser> reserveUser = [];

  @override
  void initState() {
    super.initState();
    uid = context.read<Appdata>().uid;
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _events = {};
    getAllRequest(); // Fetch events from the API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('ปฏิทิน')),
        backgroundColor: const Color(0xFF8C6C59),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: _getEventsForDay,
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  int eventCount = events.length;
                  if (eventCount > 0) {
                    // Generate a list of dots based on event count
                    return Positioned(
                      bottom: 1,
                      child: Row(
                        children: List.generate(eventCount, (index) {
                          return Container(
                            margin: EdgeInsets.only(right: 2.0),
                            height: 4.0,
                            width: 4.0,
                            decoration: BoxDecoration(
                              color: Colors.blue, // Change color if necessary
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            ..._getEventsForDay(_selectedDay).map((event) {
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                elevation: 4.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(event.split(' at ')[0],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                          ),
                          Text(
                            'Time: ${event.split(' at ')[1]}',
                          ),
                        ],
                      ),
                      Text('Time: ${event.split(' at ')[2]}',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  Future<void> getAllRequest() async {
    var config = await Configuration.getConfig();
    String url = config['apiEndPoint'];

    final response = await http.get(
      Uri.parse("$url/reserve/user/calendar/$uid"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    var decode = jsonDecode(response.body);
    reserveUser = (decode as List)
        .map((jsonitem) => ReserveDataUser.fromJson(jsonitem))
        .toList();

    _events = {};

    reserveUser.forEach((book) {
      DateTime eventDate =
          DateTime.parse(book.date); // Convert string to DateTime
      eventDate = DateTime(eventDate.year, eventDate.month,
          eventDate.day); // Normalize to just the date, without time

      if (_events[eventDate] == null) {
        _events[eventDate] = [];
      }
      _events[eventDate]!.add(
          '${book.clinicname} at ${book.name} at ${DateFormat('HH:mm').format(DateTime.parse(book.date))}'); // Add the event details
    });

    log(_events.toString());

    setState(() {});
  }
}
