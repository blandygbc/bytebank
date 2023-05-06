import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:http/src/response.dart';

const transactionsPath = '/transactions';

class TransferWebclient {
  Future<List<Transfer>> findAllTransfers() async {
    final url = Webclient.buildApiUri(transactionsPath);
    final response = await Webclient.getClient()
        .get(url)
        .timeout(const Duration(seconds: 5));
    return _getTransfersList(json.decode(response.body));
  }

  List<Transfer> _getTransfersList(List<dynamic> decodedJson) {
    return List<Transfer>.from(decodedJson.map((map) => Transfer.fromMap(map)));
  }

  Future<Transfer> save(Transfer transfer, String password) async {
    var headers = Webclient.getBasicHeaders();
    headers.update('password', (value) => password);
    final response = await Webclient.getClient().post(
      Webclient.buildApiUri(transactionsPath),
      headers: headers,
      body: transfer.toJson(),
    );
    if (response.statusCode != 200) {
      _throwHttpError(response.statusCode);
    }
    return Transfer.fromJson(response.body);
  }

  void _throwHttpError(int statusCode) =>
      throw Exception(_statusCodesMessages[statusCode]);

  final Map<int, String> _statusCodesMessages = {
    400: "Invalid transfer",
    401: "Authentication error",
  };
}
