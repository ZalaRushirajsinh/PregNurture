import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100),
            SizedBox(height: 16),
            Text('User Profile'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality here
                Navigator.popAndPushNamed(context, '/splash');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
