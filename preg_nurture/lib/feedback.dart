import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State {
  TextEditingController feedbackController = TextEditingController();
  List<Map<String, dynamic>> feedbackList =
      []; // List to store feedback entries with time and date

  @override
  void initState() {
    super.initState();
    loadFeedback(); // Load stored feedback when screen initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'We would love to hear your feedback!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: feedbackController,
              maxLines: 5, // Allow multiple lines for longer feedback
              decoration: InputDecoration(
                labelText: 'Feedback',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                submitFeedback();
              },
              child: Text('Submit Feedback'),
            ),
            SizedBox(height: 24.0), // Space for displaying stored feedback
            Text(
              'Stored Feedback:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: feedbackList.length,
                itemBuilder: (context, index) {
                  String feedback = feedbackList[index]['feedback'];
                  String timestamp = feedbackList[index]['timestamp'];
                  return ListTile(
                    title: Text(feedback),
                    subtitle: Text(timestamp),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submitFeedback() async {
    String feedback = feedbackController.text;

    // Check if feedback is not empty
    if (feedback.isNotEmpty) {
      DateTime now = DateTime.now();
      String timestamp =
          '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}';

      setState(() {
        feedbackList.add({
          'feedback': feedback,
          'timestamp': timestamp,
        }); // Add feedback with timestamp to the list
      });

      // Save feedback list to local storage (SharedPreferences)
      await saveFeedback();

      // Clear the feedback text field after submission
      feedbackController.clear();
    }

    // Display feedback submission confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Feedback Submitted'),
        content: Text('Thank you for your feedback:\n\n$feedback'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> saveFeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serializedFeedbackList = feedbackList.map((entry) {
      return '${entry['feedback']}|${entry['timestamp']}';
    }).toList();
    await prefs.setStringList('feedbackList', serializedFeedbackList);
  }

  Future<void> loadFeedback() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? storedFeedback = prefs.getStringList('feedbackList');
    if (storedFeedback != null) {
      List<Map<String, dynamic>> loadedFeedbackList = [];
      for (String entry in storedFeedback) {
        List<String> parts = entry.split('|');
        if (parts.length == 2) {
          loadedFeedbackList.add({
            'feedback': parts[0],
            'timestamp': parts[1],
          });
        } else {
          print('Invalid feedback entry: $entry'); // Log invalid entries
        }
      }
      setState(() {
        feedbackList = loadedFeedbackList; // Update feedback list
      });
    } else {
      print('No stored feedback found');
    }
  }
}
