import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/contact_lists.dart';
import 'package:contacts/new_contact_view.dart';
import 'package:contacts/search_contacts.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Contacts"),
          backgroundColor: const Color.fromARGB(255, 209, 127, 3),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchContact(dbService: dbService),
                  ),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
            ),
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
                size: 30,
              ),
            ),
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
                  allContacts.sort((a, b) =>
                      a.name.toLowerCase().compareTo(b.name.toLowerCase()));
                  final Map<String, List<Contacts>> groupedContacts = {};
                  for (var contact in allContacts) {
                    final firstLetter = contact.name.isNotEmpty &&
                            RegExp(r'^[A-Za-z]')
                                .hasMatch(contact.name.trim()[0])
                        ? contact.name[0].toUpperCase()
                        : "#"; // Use '#' for names without valid letters
                    if (!groupedContacts.containsKey(firstLetter)) {
                      groupedContacts[firstLetter] = [];
                    }
                    groupedContacts[firstLetter]!.add(contact);
                  }
                  final sortedKeys = groupedContacts.keys.toList()
                    ..sort((a, b) {
                      if (a == '#') return 1;
                      if (b == '#') return -1;
                      return a.compareTo(b);
                    });
                  if (allContacts.isEmpty) {
                    return const Center(child: Text("No contacts Availabel"));
                  }
                  return GroupedContactsList(
                    sortedKeys: sortedKeys,
                    groupedContacts: groupedContacts,
                    dbService: dbService,
                  );
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
