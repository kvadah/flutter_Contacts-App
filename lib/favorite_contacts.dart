import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Utilities/colors.dart';
import 'package:contacts/contact_detail.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  final DbService dbService;
  const Favourites({super.key, required this.dbService});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Contacts> favContacts = [];

  void getFavContacts() async {
    final contacts = await widget.dbService.getFav();
    setState(() {
      favContacts = contacts;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Favourites',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          if (favContacts.isEmpty)
            const Text(
              'No favorite contacts',
              style: TextStyle(color: Colors.white),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: favContacts.length,
              itemBuilder: (context, index) {
                final contact = favContacts[index];
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
                      trailing: const Icon(Icons.star, color: Colors.yellow),
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
