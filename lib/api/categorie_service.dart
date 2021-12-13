import 'dart:convert';

import 'package:http_interceptor/http/intercepted_client.dart';

import 'interceptor/access_token.dart';

class CategorieService {
  InterceptedClient httpCli = clientIntercepted;

  Future<List> getAll() async {
    dynamic categories;
    try {
      var uri = Uri.parse("https://2712-41-83-49-211.ngrok.io/api/categories");
      final response = await httpCli.get(uri);
      if (response.statusCode == 200) {
        categories = jsonDecode(response.body) as List;
      } else {
        throw Exception("Une erreur s'est produite. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return categories;
  }
}
