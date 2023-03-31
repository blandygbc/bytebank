import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transfer.dart';

const transactionsPath = '/transactions';

class TransferWebclient {
  Future<List<Transfer>> findAllTransfers() async {
    final url = buildApiUri(transactionsPath);
    final response = await client.get(url).timeout(const Duration(seconds: 5));
    return _getTransfersList(json.decode(response.body));
  }

  List<Transfer> _getTransfersList(List<dynamic> decodedJson) {
    return List<Transfer>.from(decodedJson.map((map) => Transfer.fromMap(map)));
  }

  Future<Transfer> save(Transfer transfer) async {
    final response = await client.post(buildApiUri(transactionsPath),
        headers: basicHeader, body: transfer.toJson());
    return Transfer.fromJson(response.body);
  }
}
