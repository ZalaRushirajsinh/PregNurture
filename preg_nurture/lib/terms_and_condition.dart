import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool _acceptedTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to PregNurture, a mobile application designed to provide information and support related to pregnancy and nurturing. By downloading, accessing, or using this application, you agree to comply with and be bound by the following terms and conditions:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Informational Purposes Only: The content provided in this application, including articles, tips, and resources, is for informational purposes only and should not substitute professional medical advice. Always consult with your healthcare provider for personalized medical guidance.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'User Responsibility: Users are responsible for the accuracy and completeness of the information they provide within the application. It is crucial to ensure that any data entered or shared is correct and up-to-date.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Privacy Policy: Our privacy policy governs the collection, storage, and use of personal information. By using this application, you consent to the terms outlined in our privacy policy.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            // Add more terms as needed

            // Checkbox for accepting terms
            Row(
              children: [
                Checkbox(
                  value: _acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptedTerms = value!;
                    });
                  },
                ),
                Text(
                  'I accept the Terms & Conditions',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),

            SizedBox(height: 24.0),

            // Accept button
            ElevatedButton(
              onPressed: _acceptedTerms
                  ? () {
                      // Navigate to the next screen or perform desired action
                      // when terms are accepted
                    }
                  : null,
              child: Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
