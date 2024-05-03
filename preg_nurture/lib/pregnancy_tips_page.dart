import 'package:flutter/material.dart';

class PregnancyTipsPage extends StatelessWidget {
  const PregnancyTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregnancy Tips'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            title: Text(
              'Dos and Don\'ts:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Do: Take prenatal vitamins regularly.',
            ),
          ),
          ListTile(
            title: Text(
              'Do: Eat a balanced diet rich in fruits, vegetables, and whole grains.',
            ),
          ),
          ListTile(
            title: Text(
              'Don\'t: Smoke or drink alcohol during pregnancy.',
            ),
          ),
          ListTile(
            title: Text(
              'Do: Stay hydrated by drinking plenty of water.',
            ),
          ),
          ListTile(
            title: Text(
              'Don\'t: Lift heavy objects or engage in strenuous activities without consulting your doctor.',
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text(
              'Useful Tips:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Take short walks daily to stay active and improve circulation.',
            ),
          ),
          ListTile(
            title: Text(
              'Get plenty of rest and sleep to support your body during pregnancy.',
            ),
          ),
          ListTile(
            title: Text(
              'Avoid foods that are high in mercury, such as certain types of fish.',
            ),
          ),
          ListTile(
            title: Text(
              'Attend regular prenatal check-ups with your healthcare provider.',
            ),
          ),
          ListTile(
            title: Text(
              'Practice relaxation techniques like deep breathing or prenatal yoga to reduce stress.',
            ),
          ),
        ],
      ),
    );
  }
}
