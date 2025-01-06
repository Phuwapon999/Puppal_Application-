import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
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
          ElevatedButton(onPressed: confirmDate, child: const Text('ยืนยัน'))
        ],
      ),
    );
  }

  void confirmDate() {}
}
