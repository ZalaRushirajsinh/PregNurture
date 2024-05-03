import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(PregnancyCalculatorApp());
}

class PregnancyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pregnancy Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PregnancyCalculatorScreen(),
    );
  }
}

class PregnancyCalculatorScreen extends StatefulWidget {
  @override
  _PregnancyCalculatorScreenState createState() =>
      _PregnancyCalculatorScreenState();
}

class _PregnancyCalculatorScreenState extends State<PregnancyCalculatorScreen> {
  final _lastPeriodController = TextEditingController();
  final _dueDateController = TextEditingController();
  int _weeksPregnant = 0;

  @override
  void dispose() {
    _lastPeriodController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        controller.text = formattedDate;
      });
    }
  }

  void _calculateWeeksPregnant() {
    final lastPeriod =
        DateFormat('dd-MM-yyyy').parse(_lastPeriodController.text);
    final dueDate = DateFormat('dd-MM-yyyy').parse(_dueDateController.text);
    final differenceInWeeks =
        (dueDate.difference(lastPeriod).inDays / 7).floor();
    setState(() {
      _weeksPregnant = differenceInWeeks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pregnancy Calculator'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to dashboard
          },
        ),
      ),
      backgroundColor: Colors.pink[50], // Set background color to pinkish
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/tracer.jpg', // Replace with your image asset
              height: 250,
              width: 350,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _lastPeriodController,
              decoration: InputDecoration(
                labelText: 'Last Period (DD-MM-YYYY)',
              ),
              onTap: () => _selectDate(context, _lastPeriodController),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _dueDateController,
              decoration: InputDecoration(
                labelText: 'Todays Date (DD-MM-YYYY)',
              ),
              onTap: () => _selectDate(context, _dueDateController),
            ),
            SizedBox(height: 20),
            Center(
              // Center the Calculate button
              child: ElevatedButton(
                onPressed: _calculateWeeksPregnant,
                child: Text('Calculate'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              // Center the Weeks Pregnant output
              child: Text(
                'Weeks Pregnant: $_weeksPregnant',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
