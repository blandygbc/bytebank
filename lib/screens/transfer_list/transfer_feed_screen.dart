import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer_form/transfer_form_screen.dart';
import 'package:bytebank/screens/transfer_list/widgets/transfer_feed_item.dart';
import 'package:flutter/material.dart';

class TransferFeedScreen extends StatefulWidget {
  final List<Transfer> _transfers = [];
  TransferFeedScreen({
    super.key,
  });

  @override
  State<TransferFeedScreen> createState() => _TransferFeedScreenState();
}

class _TransferFeedScreenState extends State<TransferFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => TransferFormScreen(),
              ))
              .then((value) => _updateList(value));
        },
        tooltip: 'Adicionar uma transferência',
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: widget._transfers.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfers[index];
          return TransferFeedItem(transfer);
        },
      ),
    );
  }

  void _updateList(value) {
    if (value != null) {
      final transfer = value as Transfer;
      setState(() {
        widget._transfers.add(transfer);
      });
    }
  }
}
