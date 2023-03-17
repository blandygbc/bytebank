import 'package:bytebank/database/contacts_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  final _contactsDao = ContactsDao();
  ContactsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ContactForm(),
            ));
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
                    return _ContactItem(contact: contact);
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

class _ContactItem extends StatelessWidget {
  final Contact contact;
  const _ContactItem({
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          contact.account.toString(),
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
