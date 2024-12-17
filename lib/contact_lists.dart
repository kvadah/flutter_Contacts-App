import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Utilities/colors.dart';
import 'package:contacts/contact_detail.dart';
import 'package:flutter/material.dart';

class GroupedContactsList extends StatelessWidget {
  final List<String> sortedKeys; // List of sorted letters for headers
  final Map<String, List<Contacts>> groupedContacts;
  const GroupedContactsList({
    super.key,
    required this.sortedKeys,
    required this.groupedContacts,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final letter = sortedKeys[index];
        final contacts = groupedContacts[letter]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                letter,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            ...contacts.map((contact) {
              final avatarColor = getRandomColor();
              final initial =
                  contact.name.isNotEmpty ? contact.name[0].toUpperCase() : "#";
              return Container(
                margin: const EdgeInsets.only(top: 5, left: 0.5, right: 0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(166, 53, 44, 44),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: SizedBox(
                  height: 50,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: avatarColor,
                      child: Text(initial),
                    ),
                    title: Text(
                      contact.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactDetail(
                                    contact: contact,
                                    avatarColor: avatarColor,
                                    letter: initial,
                                  )));
                    },
                  ),
                ),
              );
            })
          ],
        );
      },
    );
  }
}
