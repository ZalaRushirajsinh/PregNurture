import 'package:flutter/material.dart';

class Sleepscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Cycle'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sleep Tracking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            SleepTrackingForm(),
            SizedBox(height: 16.0),
            Text(
              '               Tips for Better Sleep:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              '1 Maintain a consistent sleep schedule by going to bed and waking up at the same time every day, even on weekends.',
            ),
            Text(
              '2 Create a relaxing bedtime routine, such as reading a book, taking a warm bath, or practicing meditation, to signal to your body that its time to wind down.',
            ),
            Text(
              '3 Ensure your sleep environment is conducive to sleep by keeping your bedroom dark, quiet, and at a comfortable temperature.',
            ),
            Text(
              '4 Limit exposure to screens (phones, tablets, computers) before bedtime, as the blue light emitted can disrupt your sleep cycle.',
            ),
            Text(
              '5 Avoid caffeine and heavy meals close to bedtime, as they can interfere with your ability to fall asleep.',
            ),
            Text(
              '6 Get regular exercise during the day, but avoid vigorous exercise too close to bedtime, as it can stimulate your body and make it harder to fall asleep.',
            ),
            Text(
              '7 If youre having trouble sleeping, try relaxation techniques such as deep breathing exercises or progressive muscle relaxation.',
            ),
            Text(
              '8 Consider seeking professional help if you consistently have difficulty falling or staying asleep, as it could be a sign of an underlying sleep disorder.',
            ),
          ],
        ),
      ),
    );
  }
}

class SleepTrackingForm extends StatefulWidget {
  @override
  _SleepTrackingFormState createState() => _SleepTrackingFormState();
}

class _SleepTrackingFormState extends State<SleepTrackingForm> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _bedTime = TimeOfDay.now();
  TimeOfDay _wakeUpTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bed Time',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                setState(() {
                  _bedTime = selectedTime;
                });
              }
            },
            readOnly: true,
            controller: TextEditingController(
              text: _bedTime.format(context),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select bed time',
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Wake Up Time',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            onTap: () async {
              TimeOfDay? selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                setState(() {
                  _wakeUpTime = selectedTime;
                });
              }
            },
            readOnly: true,
            controller: TextEditingController(
              text: _wakeUpTime.format(context),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select wake up time',
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Submit form data
      // You can save the sleep tracking data to a database or perform any other action
      print('Bed Time: ${_bedTime.format(context)}');
      print('Wake Up Time: ${_wakeUpTime.format(context)}');

      // Provide sleep cycle recommendation
      double sleepHours = _calculateSleepHours(_bedTime, _wakeUpTime);
      String sleepDurationRecommendation =
          getSleepDurationRecommendation(sleepHours);
      TimeOfDay optimalBedTime = calculateOptimalBedTime(_wakeUpTime);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sleep Recommendations'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Duration: $sleepDurationRecommendation'),
                SizedBox(height: 8.0),
                Text('Optimal Bed Time: ${optimalBedTime.format(context)}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }
  }

  double _calculateSleepHours(TimeOfDay bedTime, TimeOfDay wakeUpTime) {
    int bedMinutes = bedTime.hour * 60 + bedTime.minute;
    int wakeUpMinutes = wakeUpTime.hour * 60 + wakeUpTime.minute;
    int sleepDurationMinutes = (wakeUpMinutes - bedMinutes).abs();

    return sleepDurationMinutes / 60; // Convert minutes to hours
  }
}

String getSleepDurationRecommendation(double sleepHours) {
  // Provide sleep duration recommendation based on calculated sleep hours
  // Customize this based on your criteria
  // Example: Suggest a specific range of hours for optimal sleep
  if (sleepHours >= 7) {
    return 'You are getting enough sleep. Aim to maintain this duration for optimal health.';
  } else if (sleepHours >= 6 && sleepHours < 7) {
    return 'You are close to the recommended sleep duration. Try to get at least 7 hours for optimal health.';
  } else {
    return 'You may not be getting enough sleep. Aim for at least 7 hours of sleep per night for optimal health.';
  }
}

TimeOfDay calculateOptimalBedTime(TimeOfDay wakeUpTime) {
  // Calculate and suggest an optimal bedtime based on wake-up time
  // Customize this based on your criteria
  // Example: Subtract the recommended sleep duration from wake-up time
  int recommendedSleepDuration =
      8; // Example: Recommended sleep duration in hours
  int optimalBedHour = wakeUpTime.hour - recommendedSleepDuration;
  if (optimalBedHour < 0) {
    optimalBedHour += 24; // Adjust for negative values (next day)
  }
  return TimeOfDay(hour: optimalBedHour, minute: wakeUpTime.minute);
}
