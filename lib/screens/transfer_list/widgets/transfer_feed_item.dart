import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

class TransferFeedItem extends StatelessWidget {
  final Transfer _transfer;
  const TransferFeedItem(this._transfer, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.contact.toString()),
      ),
    );
  }
}
