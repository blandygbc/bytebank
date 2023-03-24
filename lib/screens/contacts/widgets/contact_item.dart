import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final String name;
  final String account;
  const ContactItem({
    super.key,
    required this.name,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          account,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
