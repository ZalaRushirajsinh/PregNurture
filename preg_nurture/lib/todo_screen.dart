import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:shared_preferences/shared_preferences.dart';

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  List<TaskItem> tasks = [];
  List<TaskItem> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadSelectedTasks(); // Load previously selected tasks
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTasks = prefs.getStringList('tasks') ?? [];
    setState(() {
      tasks = savedTasks.map((task) {
        return TaskItem(title: task, isCompleted: false);
      }).toList();
    });
  }

  Future<void> _loadSelectedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSelectedTasks = prefs.getStringList('selectedTasks') ?? [];
    setState(() {
      selectedTasks = savedSelectedTasks.map((task) {
        return TaskItem(title: task, isCompleted: false);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prenatal Care Tasks
            Text(
              'Tasks',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            // Dynamic Task List
            Column(
              children: tasks.map((task) {
                return TaskItem(
                  title: task.title,
                  isCompleted: task.isCompleted,
                  onSelected: (selected) {
                    updateSelectedTasks(selected, task.title);
                  },
                  onDelete: () {
                    deleteTask(task.title);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            // Add Task Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showAddTaskDialog();
                },
                child: Text('Add Task'),
              ),
            ),
            SizedBox(height: 16.0),
            // Graph
            selectedTasks.isNotEmpty
                ? Container(
                    height: 300,
                    child: buildChart(),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog() {
    String newTask = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Enter task name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(TaskItem(title: newTask, isCompleted: false));
                  _saveTasks(); // Save tasks to shared preferences
                  updateSelectedTasks(true, newTask); // Update selected tasks
                  _saveSelectedTasks(); // Save selected tasks to shared preferences
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final taskList = tasks.map((task) => task.title).toList();
    prefs.setStringList('tasks', taskList);
  }

  void _saveSelectedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedTaskList = selectedTasks.map((task) => task.title).toList();
    prefs.setStringList('selectedTasks', selectedTaskList);
  }

  void updateSelectedTasks(bool selected, String taskTitle) {
    setState(() {
      if (selected) {
        selectedTasks.add(TaskItem(title: taskTitle, isCompleted: false));
      } else {
        selectedTasks.removeWhere((item) => item.title == taskTitle);
      }
    });
  }

  void deleteTask(String taskTitle) {
    setState(() {
      tasks.removeWhere((item) => item.title == taskTitle);
      selectedTasks.removeWhere((item) => item.title == taskTitle);
      _saveTasks(); // Save updated tasks to shared preferences
      _saveSelectedTasks(); // Save updated selected tasks to shared preferences
    });
  }

  Widget buildChart() {
    List<charts.Series<TaskData, String>> seriesList = [
      charts.Series<TaskData, String>(
        id: 'Tasks',
        domainFn: (TaskData task, _) => task.taskTitle,
        measureFn: (TaskData task, _) => task.count,
        data: generateChartData(),
      )
    ];

    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: false,
    );
  }

  List<TaskData> generateChartData() {
    List<TaskData> data = [];
    Map<String, int> taskCounts = {};

    for (var task in selectedTasks) {
      taskCounts[task.title] =
          taskCounts.containsKey(task.title) ? taskCounts[task.title]! + 1 : 1;
    }

    taskCounts.forEach((key, value) {
      data.add(TaskData(taskTitle: key, count: value));
    });

    return data;
  }
}

class TaskItem extends StatelessWidget {
  final String title;
  final bool isCompleted;
  final Function(bool)? onSelected;
  final VoidCallback? onDelete;

  TaskItem({
    required this.title,
    required this.isCompleted,
    this.onSelected,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Checkbox(
        value: isCompleted,
        onChanged: onSelected != null
            ? (bool? value) => onSelected!(value ?? false)
            : null,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}

class TaskData {
  final String taskTitle;
  final int count;

  TaskData({required this.taskTitle, required this.count});
}

void main() {
  runApp(MaterialApp(
    home: ToDoScreen(),
  ));
}
