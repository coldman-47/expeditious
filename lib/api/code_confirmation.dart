import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'interceptor/access_token.dart';

class CodeConfirmation {
  InterceptedClient httpCli = clientIntercepted;

  Future<bool> confirm(String telephone, String code) async {
    bool authenticated = false;
    try {
      var uri = Uri.parse(dotenv.env['API_URL']! + "auth/confirm");
      final response = await httpCli.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'telephone': telephone, 'code': code}));
      if (response.statusCode == 200) {
        var credentials = jsonDecode(response.body) as Map<String, dynamic>;
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: credentials['token']);
        authenticated = true;
      } else {
        throw Exception(
            "Une erreur s'est produite lors de la tentative de connexion. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return authenticated;
  }
}
