import 'dart:convert';

import 'package:bytebank/http/loggin_interceptor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const apiUrl = 'http://192.168.0.183:8080';
const apiTransactions = '/transactions';
final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

Uri getApiUrl(String path) {
  return Uri(
    scheme: 'http',
    host: '192.168.0.183',
    port: 8080,
    path: path,
  );
}

Future<List<Transfer>> findAllTransfers() async {
  final url = getApiUrl(apiTransactions);
  final response = await client.get(url).timeout(const Duration(seconds: 5));
  final List<dynamic> body = json.decode(response.body);
  final List<Transfer> transfers = [];
  for (Map<String, dynamic> map in body) {
    transfers.add(Transfer.fromMap(map));
  }
  return transfers;
}

Future<Transfer> save(Transfer transfer) async {
  final response = await client.post(getApiUrl(apiTransactions),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transfer.toJson());
  return Transfer.fromJson(response.body);
}
