
import 'package:http/http.dart' as http;

import '../livraisonModel.dart';

// ignore: camel_case_types
class APiLivraison {
  Future<LivraisonModel> getLivraisonData() async {
    var uri = Uri.parse('https://5b7c-41-83-49-211.ngrok.io/api-doc/#/Livraisons/get_api_livraisons_');
    var livraisonModel;

     try{
          final response = await http.get(uri);
          if(response.statusCode == 200){
             final String responseString = response.body;

             final livraisonModel = LivraisonModel.fromJson(responseString);

          return livraisonModel;
  
    }
  } catch (e) {
     
    }
    return livraisonModel;
  }
}
