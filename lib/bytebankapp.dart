import 'package:bytebank/screens/transfer_list/transfer_list_screen.dart';
import 'package:flutter/material.dart';

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ByteBank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TransferListScreen(),
    );
  }
}
