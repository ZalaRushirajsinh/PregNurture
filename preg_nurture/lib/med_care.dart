import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Model class for medication data
class Medication {
  final String name;
  final String dosage;

  Medication({required this.name, required this.dosage});
}

// Model class for medication reminder data
class MedicationReminder {
  final TimeOfDay time;
  final String message;

  MedicationReminder({required this.time, required this.message});
}

// Provider class for managing medication data and reminders
class MedicationProvider with ChangeNotifier {
  List<Medication> medications = [];
  List<MedicationReminder> reminders = [];

  // Method to add new medication
  void addMedication(Medication medication) {
    medications.add(medication);
    notifyListeners();
  }

  // Method to delete medication
  void deleteMedication(int index) {
    medications.removeAt(index);
    notifyListeners();
  }
}

class MedCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Med Care'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => MedicationProvider(),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MedicationReminderWidget(),
              SizedBox(height: 16.0),
              MedicationListWidget(),
              SizedBox(height: 16.0),
              AddMedicationButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicationReminderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // Implement UI for medication reminders here
        // Example: Show a list of reminders, allow users to set new reminders, etc.
        );
  }
}

class MedicationListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MedicationProvider>(
      builder: (context, medicationProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medication List',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: medicationProvider.medications.length,
              itemBuilder: (context, index) {
                final medication = medicationProvider.medications[index];
                return ListTile(
                  title: Text(medication.name),
                  subtitle: Text('Dosage: ${medication.dosage}'),
                  trailing: Wrap(
                    spacing: 12.0,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          medicationProvider.deleteMedication(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          // Navigate to medication details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MedicationDetailsScreen(
                                medication: medication,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.alarm),
                        onPressed: () {
                          // Show dialog for setting reminder
                          showDialog(
                            context: context,
                            builder: (context) => SetReminderDialog(
                              medication: medication,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class MedicationDetailsScreen extends StatelessWidget {
  final Medication medication;

  const MedicationDetailsScreen({required this.medication});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medication Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medication Name: ${medication.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Dosage: ${medication.dosage}',
              style: TextStyle(fontSize: 16),
            ),
            // Add more medication details as needed
          ],
        ),
      ),
    );
  }
}

class SetReminderDialog extends StatelessWidget {
  final Medication medication;

  const SetReminderDialog({required this.medication});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TimeOfDay selectedTime = TimeOfDay.now();
    String message = '';

    return AlertDialog(
      title: Text('Set Reminder'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Add UI elements for setting reminder (e.g., time picker, message input)
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      selectedTime = pickedTime;
                    }
                  },
                  child: Text('Select Time'),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final String? value = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Enter Reminder Message'),
                      content: TextField(
                        onChanged: (value) {
                          message = value;
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(message);
                          },
                          child: Text('Save'),
                        ),
                      ],
                    ),
                  );
                  if (value != null) {
                    message = value;
                  }
                },
                icon: Icon(Icons.message),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Add logic to save reminder
            Navigator.of(context).pop();
          },
          child: Text('Save Reminder'),
        ),
      ],
    );
  }
}

class AddMedicationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Show dialog for adding new medication
        final Medication? medication = await showDialog<Medication>(
          context: context,
          builder: (context) => AddMedicationDialog(),
        );
        if (medication != null) {
          Provider.of<MedicationProvider>(context, listen: false)
              .addMedication(medication);
        }
      },
      child: Text('Add Medication'),
    );
  }
}

class AddMedicationDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Medication'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Medication Name'),
          ),
          TextField(
            controller: dosageController,
            decoration: InputDecoration(labelText: 'Dosage'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final String name = nameController.text;
            final String dosage = dosageController.text;
            if (name.isNotEmpty && dosage.isNotEmpty) {
              Navigator.of(context).pop(Medication(name: name, dosage: dosage));
            } else {
              // Provide feedback to the user if fields are empty
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Please fill in all fields.'),
              ));
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MedCareScreen(),
  ));
}
