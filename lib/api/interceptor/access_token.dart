import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AccessTokenInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    const storage = FlutterSecureStorage();
    try {
      var token = await storage.read(key: 'token');
      data.headers["authorization"] = "Bearer $token";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

InterceptedClient ClientIntercepted =
    InterceptedClient.build(interceptors: [AccessTokenInterceptor()]);
