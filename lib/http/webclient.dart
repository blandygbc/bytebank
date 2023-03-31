import 'package:bytebank/http/interceptors/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const apiUrl = 'http://192.168.0.183:8080';
final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

Uri buildApiUri(String path) {
  return Uri(
    scheme: 'http',
    host: '192.168.0.183',
    port: 8080,
    path: path,
  );
}

const basicHeader = {
  'Content-type': 'application/json',
  'password': '1000',
};
