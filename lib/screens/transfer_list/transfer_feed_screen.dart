import 'package:bytebank/http/webclients/transfer_webclient.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer_list/widgets/transfer_feed_item.dart';
import 'package:flutter/material.dart';

class TransferFeedScreen extends StatefulWidget {
  const TransferFeedScreen({
    super.key,
  });

  @override
  State<TransferFeedScreen> createState() => _TransferFeedScreenState();
}

class _TransferFeedScreenState extends State<TransferFeedScreen> {
  final TransferWebclient _webclient = TransferWebclient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      body: FutureBuilder<List<Transfer>>(
        future: _webclient.findAllTransfers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Text('Não foi possível se conectar.'),
              );
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasData) {
                final transfers = snapshot.data as List<Transfer>;
                if (transfers.isNotEmpty) {
                  return ListView.builder(
                    itemCount: transfers.length,
                    itemBuilder: (context, index) {
                      final transfer = transfers[index];
                      return TransferFeedItem(transfer);
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Não há transferências ainda.'),
                  );
                }
              }
              return const Center(
                child: Text('Não há transferências ainda.'),
              );
            default:
              break;
          }
          return const Center(
            child: Text('Unknown error.'),
          );
        },
      ),
    );
  }
}
