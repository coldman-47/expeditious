import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:nrj_express/api/interceptor/access_token.dart';

class LoginService {
  InterceptedClient client =
      InterceptedClient.build(interceptors: [AccessTokenInterceptor()]);

  Future<Map<String, dynamic>> login(int id) async {
    var parsedWeather;
    try {
      final response = await client
          .get("http://localhost:3000/auth".toUri(), params: {'id': "$id"});
      if (response.statusCode == 200) {
        parsedWeather = json.decode(response.body);
      } else {
        throw Exception(
            "Une erreur s'est produite lors de la tentative de connexion. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return parsedWeather;
  }
}
