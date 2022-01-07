import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:jwt_decode/jwt_decode.dart';

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

Future<String> getClientId() async {
  late String id;
  const storage = FlutterSecureStorage();
  try {
    var token = await storage.read(key: 'token');
    id = Jwt.parseJwt(token!)['client'];
  } catch (e) {
    print(e);
  }
  return id;
}

final Future<String> clientId = getClientId();

final InterceptedClient clientIntercepted =
    InterceptedClient.build(interceptors: [AccessTokenInterceptor()]);
