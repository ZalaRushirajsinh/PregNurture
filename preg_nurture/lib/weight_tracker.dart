import 'package:flutter/material.dart';

class WeightTrackerScreen extends StatefulWidget {
  @override
  _WeightTrackerScreenState createState() => _WeightTrackerScreenState();
}

class _WeightTrackerScreenState extends State<WeightTrackerScreen> {
  double _currentWeight = 0.0;
  double _height = 0.0;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSlider(
              label:
                  'Current Weight (kg): ${_currentWeight.toStringAsFixed(1)}',
              value: _currentWeight,
              onChanged: (value) {
                setState(() {
                  _currentWeight = value;
                  _updateProgress();
                });
              },
              min: 0.0,
              max: 150.0,
            ),
            SizedBox(height: 20),
            _buildSlider(
              label: 'Height (cm): ${_height.toStringAsFixed(1)}',
              value: _height,
              onChanged: (value) {
                setState(() {
                  _height = value;
                  _updateProgress();
                });
              },
              min: 0.0,
              max: 250.0,
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required double min,
    required double max,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label),
        Slider(
          value: value,
          onChanged: onChanged,
          min: min,
          max: max,
          divisions: 300,
          label: value.toStringAsFixed(1),
        ),
      ],
    );
  }

  void _updateProgress() {
    if (_height == 0) {
      setState(() {
        _progress = 0.0;
      });
      return;
    }

    // Assuming a BMI range of 18.5 to 24.9 is considered healthy
    double minHealthyBmi = 18.5;
    double maxHealthyBmi = 24.9;

    double minHealthyWeight =
        minHealthyBmi * ((_height / 100) * (_height / 100));
    double maxHealthyWeight =
        maxHealthyBmi * ((_height / 100) * (_height / 100));

    double minExpectedFinalWeight = minHealthyWeight - _currentWeight;
    double maxExpectedFinalWeight = maxHealthyWeight - _currentWeight;

    // Calculate the progress based on the current weight and height
    double progressPercentage = (_currentWeight - minHealthyWeight) /
        (maxHealthyWeight - minHealthyWeight);
    _progress = progressPercentage.clamp(0.0, 1.0);

    setState(() {
      // Calculate the expected final weight within the healthy BMI range
      _progress = progressPercentage.clamp(0.0, 1.0);
      _progress = (progressPercentage *
              (maxExpectedFinalWeight - minExpectedFinalWeight)) +
          minExpectedFinalWeight;
    });
  }
}

void main() {
  runApp(MaterialApp(
    home: WeightTrackerScreen(),
  ));
}
