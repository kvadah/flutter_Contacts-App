import 'package:contacts/CRUD/crud_service.dart';
import 'package:flutter/material.dart';

class NewContact extends StatefulWidget {
  final DbService dbService;
  const NewContact({super.key, required this.dbService});

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.black, // Black background
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: nameController, // White input text

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[600],
                labelText: 'Name',
                labelStyle:
                    const TextStyle(color: Colors.white54), // Gray label
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black), // Gray boundary
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.white), // White on focus
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: phoneController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[600],
                prefixIcon: const Icon(Icons.phone),
                labelText: 'Phone',
                labelStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[600],
                prefixIcon: const Icon(Icons.email),
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: addressController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[600],
                labelText: 'Address',
                labelStyle: const TextStyle(color: Colors.white54),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            Row(children: [
              TextButton(
                onPressed: () async {
                  final name = nameController.text;
                  final email = emailController.text;
                  final phone = phoneController.text;
                  final address = addressController.text;
                  final contact = Contacts(
                    name: name,
                    email: email,
                    phone: phone,
                    address: address,
                  );
                  await widget.dbService.addContact(contact);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {},
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ])
          ],
        ),
      ),
    );
  }
}
