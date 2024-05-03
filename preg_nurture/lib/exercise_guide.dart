import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> exercise;

  ExerciseDetailScreen({required this.exercise});

  @override
  Widget build(BuildContext context) {
    String? videoId = YoutubePlayer.convertUrlToId(exercise['videoUrl']);
    if (videoId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(exercise['name']),
        ),
        body: Center(
          child: Text('Invalid YouTube video URL'),
        ),
      );
    }

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              exercise['benefits'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseRecommendationsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> exercises = [
    {
      'name': 'Walking',
      'benefits':
          'BENEFITS: Improves circulation, boosts mood, and helps maintain a healthy weight.',
      'videoUrl':
          'https://www.youtube.com/watch?v=Qd4QBIoKrJM&t=29s', // Full YouTube video URL
    },
    {
      'name': 'Swimming',
      'benefits':
          'BENEFITS: Swimming is a really good form of exercise during pregnancy because the water helps support your increased weight. ',
      'videoUrl':
          'https://www.youtube.com/watch?v=SC1fxiQM0u8', // Full YouTube video URL
    },
    {
      'name': 'Running',
      'benefits':
          'BENEFITS: Running during pregnancy is fine as long as you are experienced. If you are new to running, it is not a good idea to start now.',
      'videoUrl':
          'https://www.youtube.com/watch?v=Qd4QBIoKrJM', // Full YouTube video URL
    },
    {
      'name': 'Prenatal Yoga',
      'benefits':
          'BENEFITS: This will help you relax and ease body tension with gentle stretching and breathing techniques.',
      'videoUrl':
          'https://www.youtube.com/watch?v=-RNRMS8ez78', // Full YouTube video URL
    },
    {
      'name': 'Aerobics Classes',
      'benefits':
          'BENEFITS: Classes (including online ones) created for pregnant women feature low-impact exercises.',
      'videoUrl':
          'https://www.youtube.com/watch?v=_HYzzcgndWw', // Full YouTube video URL
    },
    {
      'name': 'Pelvic floor and abdominal exercises',
      'benefits': ' BENEFITS: These types of exercise are really important in pregnancy, so try to fit them into your daily routine.'
          'They have many benefits, including strengthening your muscles and joints.'
          'You should however avoid exercises like sit-ups that involve lying on your back for longer than a few minutes (especially after 16 weeks).',
      'videoUrl':
          'https://www.youtube.com/watch?v=jWBjDk2wIUU', // Full YouTube video URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Recommendations'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseDetailScreen(
                      exercise: exercises[index],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  title: Text(
                    exercises[index]['name'],
                    style: TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(exercises[index]['benefits']),
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ExerciseRecommendationsScreen(),
  ));
}
