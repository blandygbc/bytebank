import 'package:bytebank/database/contacts_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form/contact_form.dart';
import 'package:bytebank/screens/contacts/widgets/contact_item.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final _contactsDao = ContactsDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ))
                .then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add)),
      body: FutureBuilder<List<Contact>>(
        initialData: const [],
        future: _contactsDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              if (snapshot.hasData) {
                final contacts = snapshot.data as List<Contact>;
                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final contact = contacts[index];
                    return ContactItem(
                      name: contact.name,
                      account: contact.account.toString(),
                    );
                  },
                );
              }
              break;
            default:
              return const Center(
                child: Text("Não há nenhum contato cadastrado."),
              );
          }
          return const Center(
            child: Text("Unknown error."),
          );
        },
      ),
    );
  }
}
