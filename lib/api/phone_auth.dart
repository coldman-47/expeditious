import 'dart:convert';

import 'package:http/http.dart' as http;

class PhoneAuth {
  Future<bool> login(String telephone) async {
    bool authenticated = false;
    try {
      var uri = Uri.parse("https://2712-41-83-49-211.ngrok.io/api/auth");
      final response = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'telephone': telephone,
          }));
      if (response.statusCode == 200) {
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
