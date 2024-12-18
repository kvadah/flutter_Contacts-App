import 'package:contacts/CRUD/crud_exceptions.dart';
import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Interactine_messages/generic_toast.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'New Contact',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black26,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: nameController, // White input text

                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: const Icon(Icons.person, color: Colors.black),
                  fillColor: Colors.grey[700],
                  labelText: 'Name',
                  labelStyle:
                      const TextStyle(color: Colors.white), // Gray label
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
                  fillColor: Colors.grey[700],
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  labelText: 'Phone',
                  labelStyle: const TextStyle(color: Colors.white),
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
                  fillColor: Colors.grey[700],
                  prefixIcon: const Icon(Icons.email, color: Colors.black),
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.white),
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
                  fillColor: Colors.grey[700],
                  labelText: 'Address',
                  labelStyle: const TextStyle(color: Colors.white),
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
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () async {
                          final name = nameController.text;
                          final phone = phoneController.text;

                          if (name.isNotEmpty && phone.isNotEmpty) {
                            final cancel = await showCancelDialog(
                                context: context,
                                title: 'Cancel',
                                content: 'Do you want to Disacrd changes');
                            if (cancel) {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                          }
                          // ignore: use_build_context_synchronously
                          else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final name = nameController.text;
                          final email = emailController.text;
                          final phone = phoneController.text;
                          final address = addressController.text;
                          if (name.isEmpty || phone.isEmpty) {
                            if (name.isEmpty) {
                              showToast('Name can not be empty');
                            } else {
                              showToast('Phone number Can not empty');
                            }
                          } else {
                            final contact = Contacts(
                              name: name,
                              email: email,
                              phone: phone,
                              address: address,
                            );

                            try {
                              await widget.dbService.addContact(contact);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);

                              // ignore: empty_catches
                            } on UserAlreadyRegistered {
                              showToast(
                                  'This number is already in your contacts');
                            }
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
