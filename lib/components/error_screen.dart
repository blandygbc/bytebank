import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;
  const ErrorScreen(this.errorMessage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro')),
      body: Center(child: Text(errorMessage)),
    );
  }
}
