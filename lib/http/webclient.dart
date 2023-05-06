import 'package:bytebank/http/interceptors/loggin_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const apiUrl = 'http://192.168.0.183:8080';

class Webclient {
  static Map<String, String> getBasicHeaders() {
    return {
      'Content-type': 'application/json',
      'password': '1000',
    };
  }

  static Client getClient() {
    return InterceptedClient.build(interceptors: [
      LoggingInterceptor(),
    ]);
  }

  static Uri buildApiUri(String path) {
    return Uri(
      scheme: 'http',
      host: '192.168.0.183',
      port: 8080,
      path: path,
    );
  }
}
