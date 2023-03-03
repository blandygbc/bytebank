import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  late final TextEditingController _nameEC;
  late final TextEditingController _accountEC;
  ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  @override
  void initState() {
    widget._nameEC = TextEditingController();
    widget._accountEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    widget._accountEC.dispose();
    widget._nameEC.dispose();
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
              controller: widget._nameEC,
              label: 'Full name',
              hint: 'your name here...',
              keyboardType: TextInputType.text,
            ),
            Editor(
              controller: widget._accountEC,
              label: 'Account number',
              hint: '0000',
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    if (widget._nameEC.text.compareTo('') == 0 ||
                        widget._accountEC.text.compareTo('') == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha todos os campos'),
                        ),
                      );
                    } else {
                      final name = widget._nameEC.text;
                      final accNum = int.parse(widget._accountEC.text);
                      final newContact = Contact(name: name, account: accNum);
                      Navigator.of(context).pop(newContact);
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
