import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info Screen'),
      ),
      backgroundColor: Color.fromARGB(255, 52, 169, 228),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Baby Kicks Count:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Counting your baby’s kicks is a way to monitor your baby’s wellbeing, especially in the third trimester. Your baby’s kicks can provide valuable information about their health and development. It is recommended to track your baby’s kicks every day, preferably at the same time each day.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'When to Count Kicks:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'It is usually recommended to start counting kicks in the third trimester, around 28 weeks of pregnancy. You can choose any time of day when your baby is most active, but it’s a good idea to establish a routine and count kicks at the same time each day for consistency.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'How to Count Kicks:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Find a comfortable position, preferably lying on your side. Focus on your baby’s movements and count each kick, flutter, swish, or roll as one movement. Note the time it takes to count 10 movements. Your baby should move at least 10 times in two hours.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Text(
              'When to Contact Your Doctor:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'If you notice a significant decrease in your baby’s movements or if you’re concerned about your baby’s activity level, contact your doctor immediately. Changes in fetal movement can sometimes indicate a problem, so it’s important to seek medical attention promptly.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
