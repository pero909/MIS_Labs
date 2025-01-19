import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<String>> _events = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exam Schedule')),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) => setState(() => _calendarFormat = format),
            onDaySelected: (selectedDay, _) {
              setState(() => _selectedDate = selectedDay);
            },
            eventLoader: (date) => _events[date] ?? [],
          ),
          Expanded(
            child: ListView(
              children: (_events[_selectedDate] ?? []).map((event) => ListTile(title: Text(event))).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final event = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Add Event'),
              content: TextField(
                decoration: InputDecoration(hintText: 'Enter event details'),
                onSubmitted: Navigator.of(context).pop,
              ),
            ),
          );
          if (event != null) {
            setState(() {
              _events[_selectedDate] = [...(_events[_selectedDate] ?? []), event];
            });
          }
        },
      ),
    );
  }
}
