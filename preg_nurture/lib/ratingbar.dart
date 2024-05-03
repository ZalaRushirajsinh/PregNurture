import 'package:flutter/material.dart';

class Ratingbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RatingPage(),
    );
  }
}

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State {
  int _rating = 0; // Variable to store the selected rating

// Function to update the rating when a star is tapped
  void _updateRating(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate this App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rate this app:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStar(1),
                _buildStar(2),
                _buildStar(3),
                _buildStar(4),
                _buildStar(5),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              'You rated $_rating stars',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

// Function to build a single star
  Widget _buildStar(int starCount) {
    Icon icon;
    if (starCount <= _rating) {
      icon = Icon(Icons.star, color: Colors.yellow);
    } else {
      icon = Icon(Icons.star_border, color: Colors.grey);
    }
    return GestureDetector(
      child: icon,
      onTap: () {
        _updateRating(starCount);
      },
    );
  }
}
