import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Interactine_messages/generic_toast.dart';
import 'package:contacts/contacts_view.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  final DbService dbService;
  final Contacts contact;
  const UpdateContact(
      {super.key, required this.dbService, required this.contact});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController addressController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.contact.name);
    emailController = TextEditingController(text: widget.contact.email);
    addressController = TextEditingController(text: widget.contact.address);
    phoneController = TextEditingController(text: widget.contact.phone);
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
                    color: Colors.white, fontWeight: FontWeight.bold),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
                            final updatedContact = Contacts(
                              id: widget.contact.id,
                              name: name,
                              phone: phone,
                              email: email,
                              address: address,
                              isFavorite: widget.contact.isFavorite,
                            );
                            await widget.dbService
                                .updateContact(updatedContact, name,email,address,phone,);
                            Navigator.pushAndRemoveUntil(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ContactsView()),
                                (route) => false);
                          }
                        },
                        child: const Text(
                          'Update',
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
