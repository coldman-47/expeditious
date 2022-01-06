import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nrj_express/models/livraison.dart';

import 'interceptor/access_token.dart';

class ClientService {
  InterceptedClient httpCli = clientIntercepted;

  Future<Object> historiqueLivraison(String id) async {
    dynamic historique = [];
    try {
      var uri = Uri.parse(dotenv.env['API_URL']! + "clients/$id/historique");
      final response = await httpCli.get(uri);
      if (response.statusCode == 200) {
        historique = jsonDecode(response.body);
        print(historique);
      } else {
        throw Exception("Une erreur s'est produite. \n ${response.body}");
      }
    } catch (e) {
      print(e);
    }
    return historique;
  }
}
