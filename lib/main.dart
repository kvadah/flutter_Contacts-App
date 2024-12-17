import 'package:contacts/contacts_view.dart';
import 'package:flutter/material.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        title: 'Contacts App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
     '/contacts_view': (context) =>const ContactsView(),
        },
        //returning a home page view
        home: const ContactsView(),));
}