import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactBookScreen extends StatefulWidget {
  @override
  _ContactBookScreenState createState() => _ContactBookScreenState();
}

class _ContactBookScreenState extends State<ContactBookScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.contacts),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllContactsScreen(contacts: contacts),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: additionalInfoController,
              decoration: InputDecoration(labelText: 'Additional Information'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addContact();
              },
              child: Text('Add Contact'),
            ),
            SizedBox(height: 24.0),
            Text(
              'Contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: contacts.isEmpty
                  ? Center(
                      child: Text('No contacts yet'),
                    )
                  : ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(contacts[index].name),
                          subtitle: Text(contacts[index].phoneNumber),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteContact(index);
                            },
                          ),
                          onTap: () {
                            // Handle tap on contact
                            // You can navigate to a contact details screen or show a dialog with more information
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void addContact() async {
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    String address = addressController.text;
    String additionalInfo = additionalInfoController.text;

    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      setState(() {
        contacts.add(Contact(
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          additionalInfo: additionalInfo,
        ));
      });

      // Clear text fields after adding contact
      nameController.clear();
      phoneNumberController.clear();
      addressController.clear();
      additionalInfoController.clear();

      // Save contacts to SharedPreferences
      await saveContacts();
    } else {
      // Show error message if required fields are empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Name and Phone Number are required.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void deleteContact(int index) async {
    setState(() {
      contacts.removeAt(index);
    });
    // Save contacts to SharedPreferences after deleting
    await saveContacts();
  }

  Future<void> saveContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> contactStrings =
        contacts.map((contact) => contact.toString()).toList();
    await prefs.setStringList('contacts', contactStrings);
  }

  Future<void> loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? contactStrings = prefs.getStringList('contacts');
    if (contactStrings != null) {
      List<Contact> loadedContacts =
          contactStrings.map((string) => Contact.fromString(string)).toList();
      setState(() {
        contacts = loadedContacts;
      });
    }
  }
}

class Contact {
  final String name;
  final String phoneNumber;
  final String address;
  final String additionalInfo;

  Contact({
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.additionalInfo,
  });

  @override
  String toString() {
    return '$name,$phoneNumber,$address,$additionalInfo';
  }

  factory Contact.fromString(String string) {
    List<String> parts = string.split(',');
    return Contact(
      name: parts[0],
      phoneNumber: parts[1],
      address: parts[2],
      additionalInfo: parts[3],
    );
  }
}

class AllContactsScreen extends StatelessWidget {
  final List<Contact> contacts;

  const AllContactsScreen({Key? key, required this.contacts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Contacts (${contacts.length})'),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contacts[index].name),
            subtitle: Text(contacts[index].phoneNumber),
            onTap: () {
              // Handle tap on contact
              // You can navigate to a contact details screen or show a dialog with more information
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContactBookScreen(),
  ));
}
