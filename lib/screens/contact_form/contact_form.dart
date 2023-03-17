import 'package:bytebank/components/editor.dart';
import 'package:bytebank/database/contacts_dao.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late final TextEditingController _nameEC;
  late final TextEditingController _accountEC;
  final _contactsDao = ContactsDao();

  @override
  void initState() {
    _nameEC = TextEditingController();
    _accountEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _accountEC.dispose();
    _nameEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _nameEC,
              label: 'Full name',
              hint: 'your name here...',
              keyboardType: TextInputType.text,
            ),
            Editor(
              controller: _accountEC,
              label: 'Account number',
              hint: '0000',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameEC.text.compareTo('') == 0 ||
                        _accountEC.text.compareTo('') == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos'),
                        ),
                      );
                    } else {
                      final name = _nameEC.text;
                      final accNum = _accountEC.text;
                      _contactsDao
                          .save(name: name, account: accNum)
                          .then((value) {
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
