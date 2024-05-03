import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:preg_nurture/info_screen.dart';

class KickCounterScreen extends StatefulWidget {
  @override
  _KickCounterScreenState createState() => _KickCounterScreenState();
}

class _KickCounterScreenState extends State<KickCounterScreen> {
  int _kickCount = 0;
  List<int> _kickHistory = [];
  DateTime? _firstKickTime;
  DateTime? _lastKickTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kick Counter'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor:
          const Color.fromARGB(255, 255, 229, 204), // Skinish background color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ClipOval(
            child: GestureDetector(
              onTap: () {
                _incrementKickCount();
                _vibratePhone(); // Call the function to vibrate the phone
              },
              child: Image.asset(
                'assets/foot.png', // Replace with your logo image
                height: 250,
                width: 170,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Total Kicks: $_kickCount',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          const Text(
            'Kick History:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _kickHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Kick ${index + 1}: ${_kickHistory[index]} at ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now())}',
                  ),
                );
              },
            ),
          ),
          Text(
            'First Kick: ${_firstKickTime != null ? DateFormat('hh:mm a').format(_firstKickTime!) : 'N/A'} | Last Kick: ${_lastKickTime != null ? DateFormat('hh:mm a').format(_lastKickTime!) : 'N/A'}',
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _resetKickCounter,
                child: const Text('Reset'),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            KickHistoryPage(kickHistory: _kickHistory)),
                  );
                },
                child: const Text('Complete'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _incrementKickCount() {
    final now = DateTime.now();
    setState(() {
      _kickCount++;
      _kickHistory.add(_kickCount);
      if (_firstKickTime == null) {
        _firstKickTime = now;
      }
      _lastKickTime = now;
    });
  }

  void _vibratePhone() {
    HapticFeedback.heavyImpact(); // Trigger medium intensity vibration
  }

  void _resetKickCounter() {
    setState(() {
      _kickCount = 0;
      _kickHistory.clear();
      _firstKickTime = null;
      _lastKickTime = null;
    });
  }
}

class KickHistoryPage extends StatelessWidget {
  final List<int> kickHistory;

  const KickHistoryPage({Key? key, required this.kickHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kick History'),
      ),
      body: ListView.builder(
        itemCount: kickHistory.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Kick ${index + 1}: ${kickHistory[index]} at ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now())}',
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: KickCounterScreen(),
  ));
}
