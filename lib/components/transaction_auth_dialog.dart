import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;
  const TransactionAuthDialog({
    Key? key,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<TransactionAuthDialog> createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final _passwordEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Authenticate'),
      content: TextField(
        controller: _passwordEC,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 64,
          letterSpacing: 24,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onConfirm(_passwordEC.text);
            Navigator.pop(context);
          },
          child: const Text('Confirm'),
        )
      ],
    );
  }
}
