// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:bytebank/http/exceptions/http_exception.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transfer.dart';

const transactionsPath = '/transactions';

class TransferWebclient {
  final transactionsFullPath = Webclient.buildApiUri(transactionsPath);

  Future<List<Transfer>> findAllTransfers() async {
    final response = await Webclient.getClient().get(transactionsFullPath);
    return _getTransfersList(json.decode(response.body));
  }

  List<Transfer> _getTransfersList(List<dynamic> decodedJson) {
    return List<Transfer>.from(decodedJson.map((map) => Transfer.fromMap(map)));
  }

  Future<Transfer> save(Transfer transfer, String password) async {
    var headers = Webclient.getBasicHeaders();
    headers.update('password', (value) => password);
    await Future.delayed(const Duration(seconds: 2));
    final response = await Webclient.getClient().post(
      transactionsFullPath,
      headers: headers,
      body: transfer.toJson(),
    );

    if (response.statusCode != 200) {
      throw HttpException(
          _statusCodesMessages[response.statusCode] ?? 'Unknow error');
    }
    return Transfer.fromJson(response.body);
  }

  final Map<int, String> _statusCodesMessages = {
    400: "Invalid transfer",
    401: "Authentication error",
    409: "Transfer already exists",
  };
}
