import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(
    MaterialApp(
      home: CalendarScreen(),
    ),
  );
}

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  TextEditingController _notesController = TextEditingController();
  Map<DateTime, List<String>> _notes = {};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Calendar and Notes'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Calendar'),
              Tab(text: 'Notes'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCalendarTab(),
            _buildNotesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            startingDayOfWeek: StartingDayOfWeek.monday,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) => _notes[day] ?? [],
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Today\'s Date: ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Add Note',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _notes[_focusedDay] ??= [];
                      _notes[_focusedDay]!.add(_notesController.text);
                      _notesController.clear();
                    });
                  },
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildAllNotes(),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAllNotes() {
    List<Widget> allNotes = [];

    _notes.forEach((date, notes) {
      allNotes.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes for ${DateFormat('dd-MM-yyyy').format(date)}:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notes
                    .map((note) => ListTile(
                          title: Text(note),
                        ))
                    .toList(),
              ),
              Divider(),
            ],
          ),
        ),
      );
    });

    return allNotes;
  }
}
