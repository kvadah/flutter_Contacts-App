import 'package:contacts/CRUD/crud_service.dart';
import 'package:contacts/Interactine_messages/generic_toast.dart';
import 'package:contacts/Utilities/uri_laucherss.dart';
import 'package:contacts/update_contact.dart';
import 'package:flutter/material.dart';

class ContactDetail extends StatefulWidget {
  final Contacts contact;
  final Color avatarColor;
  final String letter;
  final DbService dbService;
  const ContactDetail({
    super.key,
    required this.contact,
    required this.avatarColor,
    required this.letter,
    required this.dbService,
  });

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
                              onPressed: () async {
                                await makePhoneCall(widget.contact.phone);
                              },
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
                              onPressed: () async {
                                await sendSMS(widget.contact.phone);
                              },
                              icon: const Icon(
                                Icons.sms,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () async {
                          if (widget.contact.email!.isNotEmpty) {
                            sendEmail(widget.contact.email!);
                          }
                        },
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateContact(
                              dbService: widget.dbService,
                              contact: widget.contact,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  IconButton(
                      onPressed: () async {
                        final toBeDeleted = await showDeleteDialog(
                          context: context,
                          title: 'Delete',
                          content: 'Do you want to delete this contact',
                        );
                        if (toBeDeleted) {
                          widget.dbService.deleteContact(widget.contact.id!);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        }
                      },
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
