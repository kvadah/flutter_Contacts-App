import 'package:contacts/CRUD/crud_service.dart';
import 'package:flutter/material.dart';

class ContactDetail extends StatefulWidget {
  final Contacts contact;
  final Color avatarColor;
  final String letter;
  const ContactDetail(
      {super.key,
      required this.contact,
      required this.avatarColor,
      required this.letter});

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: const Color.fromARGB(255, 44, 40, 40),
              ),
              height: 300,
              margin: const EdgeInsets.only(top: 70),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: widget.avatarColor,
                      radius: 55,
                      child: Text(
                        widget.letter,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        widget.contact.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        'phone: +251 ${widget.contact.phone.trim().substring(1)}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 29, 123, 201),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.sms,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'email: ${widget.contact.email!}',
                          style: const TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
