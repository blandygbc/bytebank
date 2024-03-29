import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // try {
    //   data.headers['password'] = '1000';
    //   data.headers["Content-Type"] = "application/json";
    // } catch (e) {
    //   log(e.toString());
    // }
    log('Request');
    log('url: ${data.url}');
    log('headers: ${data.headers}');
    log('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    log('Response');
    log('status code: ${data.statusCode}');
    log('headers: ${data.headers}');
    log('body: ${data.body}');
    return data;
  }
}
