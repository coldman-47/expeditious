import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nrj_express/models/livraison.dart';

import 'interceptor/access_token.dart';

class LivraisonService {
  InterceptedClient httpCli = clientIntercepted;

  Future<Object> create(Livraison livraison) async {
    late dynamic reqResponse;
    try {
      var uri = Uri.parse(dotenv.env['API_URL']! + "/api/livraisons/add");
      final response = await httpCli.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(livraison.toJson()));
      if (response.statusCode == 200) {
        reqResponse = true;
      } else {
        reqResponse = response.body;
        throw Exception("Une erreur s'est produite. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    print(reqResponse);
    return reqResponse;
  }
}
