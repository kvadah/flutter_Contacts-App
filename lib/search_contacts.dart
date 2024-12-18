import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Utilities/colors.dart';
import 'package:contacts/contact_detail.dart';
import 'package:flutter/material.dart';

class SearchContact extends StatefulWidget {
  final DbService dbService;
  const SearchContact({super.key, required this.dbService});

  @override
  State<SearchContact> createState() => _SearchContactState();
}

class _SearchContactState extends State<SearchContact> {
  late final TextEditingController _searchController;
  late List<Contacts> searchedContacts;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    searchedContacts = []; // Initialize with an empty list.

    // Initially load all contacts
    searchContacts('');
  }

  // Function to search contacts based on query
  void searchContacts(String query) async {
    if (query.isEmpty) {
      // If no query, show all contacts
      setState(() {
        searchedContacts = [];
      });
    } else {
      // Fetch contacts matching the search query
      final results = await widget.dbService.getContactsByName(query);
      setState(() {
        searchedContacts = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text(
          'Search Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          // Search TextField
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Search Contacts',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                // Listen for changes in the TextField and update the contact list
                onChanged: (query) {
                  searchContacts(query);
                },
              ),
            ),
          ),

          // List of filtered contacts
          Expanded(
            child: ListView.builder(
              itemCount: searchedContacts.length,
              itemBuilder: (context, index) {
                final contact = searchedContacts[index];
                final avatarColor = getRandomColor();
                final initial = contact.name.isNotEmpty
                    ? contact.name[0].toUpperCase()
                    : "#";
                return Container(
                  margin: const EdgeInsets.only(top: 5, left: 0.5, right: 0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(166, 53, 44, 44),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: SizedBox(
                    height: 60,
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
                      subtitle: Text(
                        contact.phone,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactDetail(
                              contact: contact,
                              avatarColor: avatarColor,
                              letter: initial,
                              dbService: widget.dbService,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
