import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(Settings());
}

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manage Options',
      theme: ThemeData.light(),
      home: ManageOptionsScreen(),
    );
  }
}

class ManageOptionsScreen extends StatefulWidget {
  @override
  _ManageOptionsScreenState createState() => _ManageOptionsScreenState();
}

class _ManageOptionsScreenState extends State<ManageOptionsScreen> {
  late bool _confirmChoices = false;
  late bool _acceptAll = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _confirmChoices = prefs.getBool('confirmChoices') ?? false;
      _acceptAll = prefs.getBool('acceptAll') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('confirmChoices', _confirmChoices);
    prefs.setBool('acceptAll', _acceptAll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text('Confirm Choices'),
              trailing: Switch(
                value: _confirmChoices,
                onChanged: (value) {
                  setState(() {
                    _confirmChoices = value;
                    _savePreferences(); // Save switch state
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Accept All'),
              trailing: Switch(
                value: _acceptAll,
                onChanged: (value) {
                  setState(() {
                    _acceptAll = value;
                    _savePreferences(); // Save switch state
                  });
                },
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                _showInformationDialog(context); // Show information dialog
              },
              child: Text('Manage Options'),
            ),
          ],
        ),
      ),
    );
  }

  void _showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information'),
          content: Text(
            'This app collects and uses your personal data for certain purposes. By accepting all, you agree to the terms of our privacy policy. Please review our privacy policy for more information.',
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
