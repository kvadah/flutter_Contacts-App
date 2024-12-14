import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/new_contact_view.dart';
import 'package:flutter/material.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({super.key});

  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late final DbService dbService;
  late final Stream<List<Contacts>> contactsStram;

  @override
  void initState() {
    dbService = DbService();
    dbService.initDatabase();
    contactsStram = dbService.contactsStreamer.stream;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
          backgroundColor: const Color.fromARGB(255, 209, 127, 3),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewContact(dbService: dbService),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
                size: 20,
              ),
            )
          ],
        ),
        body: StreamBuilder(
          stream: contactsStram,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  final allContacts = snapshot.data as List<Contacts>;
                  if (allContacts.isEmpty) {
                    return const Center(child: Text("No contacts Availabel"));
                  }
                  return ListView.builder(
                      itemCount: allContacts.length,
                      itemBuilder: (context, index) {
                        final contact = allContacts[index];
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.phone),
                        );
                      });
                }
                return const Text("no snapshot data");
              default:
                return const Text(
                    'Connection state biether waiting nor active');
            }
          },
        ));
  }
}
