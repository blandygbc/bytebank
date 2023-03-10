import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final Icon? icon;
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const Editor({
    super.key,
    required this.controller,
    this.icon,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
        ),
        decoration: InputDecoration(
          icon: icon,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
