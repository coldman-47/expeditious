import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/http_interceptor.dart';

class AccessTokenInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      data.headers["authorization"] = "Bearer " "token";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}
