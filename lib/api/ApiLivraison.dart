import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:nrj_express/models/delivery_model.dart';

class DeliveryController {

  Future<Livraison> newLivraison(String lieuArrivee, String lieuDepart) async {

    const storage = FlutterSecureStorage();

    final token = await storage.read(key: 'token');

    final response = await http.post(Uri.parse(''),
      headers: {  'Accept' : 'application/json', 'xx-token' : token! },
      body: {
        'lieuArrivee' : lieuArrivee,
        'lieuDepart' :lieuDepart
      }
    );

    return Livraison.fromJson( jsonDecode( response.body ) );
  } 

}
