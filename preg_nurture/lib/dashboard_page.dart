import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preg_nurture/Calendar_diary.dart';
import 'package:preg_nurture/Contactbook.dart';
import 'package:preg_nurture/Preg_Calc.dart';
import 'package:preg_nurture/chat.dart';
import 'package:preg_nurture/exercise_guide.dart';
import 'package:preg_nurture/feedback.dart';
import 'package:preg_nurture/ratingbar.dart';
import 'package:preg_nurture/settings.dart';
import 'package:preg_nurture/sleep_screen.dart';
import 'package:preg_nurture/kick_counter.dart';
import 'package:preg_nurture/med_care.dart';
import 'package:preg_nurture/pregnancy_tips_page.dart';
import 'package:preg_nurture/terms_and_condition.dart';
import 'package:preg_nurture/todo_screen.dart';
import 'package:preg_nurture/weight_tracker.dart';

class Book {
  final String title;
  final String imagePath;

  Book({required this.title, required this.imagePath});
}

class DashboardPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PregNurture'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sos_outlined),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 188, 223),
              ),
              child: Text(
                'Welcome back Rushii',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/profile'); // Use Get.toNamed for named routes
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_services_outlined),
              title: const Text('Med-Care'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedCareScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Contact Books'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactBookScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_applications_sharp),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text('Feedback'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('Terms And Conditions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TermsAndConditionsPage()),
                );
                // Use Get.toNamed for named routes
              },
            ),
            ListTile(
              leading: const Icon(Icons.star_half_rounded),
              title: const Text('Rate Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RatingPage()),
                );
                // Use Get.toNamed for named routes
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 93, 188, 223),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: _buildGridView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatPage()),
          );
        },
        child: const Icon(Icons.chat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Pregnancy Calc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.turned_in_not_sharp),
            label: 'Tips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_sharp),
            label: 'Notes',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PregnancyCalculatorApp()),
            );
          } else if (index == 1) {
            Get.to(() => const PregnancyTipsPage());
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildGridView() {
    List<Map<String, String>> containers = [
      {'title': 'Weight Tracker', 'imagePath': 'assets/weight.jpg'},
      {'title': 'Kicks Counter', 'imagePath': 'assets/kick.jpg'},
      {'title': 'Contraction Counter', 'imagePath': 'assets/contract.jpeg'},
      {'title': 'Exercise Guide', 'imagePath': 'assets/exercise.png'},
      {'title': 'Sleep Cycle', 'imagePath': 'assets/sleep.png'},
      {'title': 'TO-DO', 'imagePath': 'assets/todo.png'},
      // Add more containers as needed
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 3.0,
      mainAxisSpacing: 3.0,
      children: List.generate(containers.length, (index) {
        String title = containers[index]['title']!;
        String imagePath = containers[index]['imagePath']!;
        return _buildContainer(title, imagePath);
      }),
    );
  }

  Widget _buildContainer(String title, String imagePath) {
    return Card(
      child: GestureDetector(
        onTap: () {
          if (title == 'Kicks Counter') {
            Get.to(KickCounterScreen());
          } else if (title == 'Weight Tracker') {
            Get.to(WeightTrackerScreen());
          } else if (title == 'Exercise Guide') {
            Get.to(ExerciseRecommendationsScreen());
          } else if (title == 'Sleep Cycle') {
            Get.to(Sleepscreen());
          } else if (title == 'TO-DO') {
            Get.to(ToDoScreen());
          } else {
            // Handle other containers' onTap actions here
            // For demonstration, let's print the selected title
            print('Selected: $title');
          }
        },
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 120,
              width: 160,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SOS Options'),
          content: const Text('Implement your SOS options here.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('SOS'),
            ),
          ],
        );
      },
    );
  }
}
