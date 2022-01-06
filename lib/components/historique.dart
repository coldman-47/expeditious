import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nrj_express/api/categorie_service.dart';
import 'package:nrj_express/api/interceptor/access_token.dart';
import 'package:nrj_express/models/livraison.dart';
import 'dart:convert';


Future<List<Livraison>> fetchLivraison() async {
  InterceptedClient httpCli = clientIntercepted;

  var uri = Uri.parse(
      dotenv.env['API_URL']! + "clients/61c098a8ba066d250792a425/historique");
  final response = await httpCli.get(uri);
  return getLivraison(response.body);
}

List<Livraison> getLivraison(responseBody) {
  final body = json.decode(responseBody);
  List<Livraison> livraisons = [];
  final parseLivraisons = body["livraisons"];
  if (parseLivraisons.length > 0) {
    for (var i in parseLivraisons) {
      livraisons.add(Livraison.fromJson(i));
    }
  }
  return livraisons;
}

class Historique extends StatefulWidget {
const Historique( {Key? key,   })  : super(key: key);
  @override
  _HistoriqueState createState() => _HistoriqueState(); 
}

class _HistoriqueState extends State<Historique> {
  late List categories = [];
  CategorieService categorieSrv = CategorieService();
 

  _loadCategories() async {
    var _categories = await categorieSrv.getAll();
    setState(() {
      categories = _categories;
    });
  }

 @override
  void initState() {
    _loadCategories();
    super.initState();
    fetchLivraison();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.blue,
            title: const Text('Historique'),
            elevation: 0),
        body: FutureBuilder<List<Livraison>>(
            future: fetchLivraison(),
            builder: (context, AsyncSnapshot snapshot)
             {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      var livraison = snapshot.data[i];
                      for (var categorie in categories) 
                      {
                        if(livraison.categorie == categorie['_id']){
                          livraison.categorie = categorie['label'];  
                        }
                      }
                      return Card(
                        child: ListTile(
                          onTap: () => _ShowDialogFun(context, livraison) ,
                          title: Text('livraison $i'),
                         ));
                    } );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}

// ignore: non_constant_identifier_names
_ShowDialogFun(context, livraison) {
  
  return showDialog(
      context:context,
      builder: (context) {
        return Center(
            child: Material(
                type: MaterialType.transparency,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 370,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Text('Résumé',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30))),

                          Container(padding: const EdgeInsets.all(20),
                              child:
                                  Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(
                                         height: 40,
                                         child: Text('Lieu de récupération: ' + (livraison.lieuDepart),
                                         style: const TextStyle(fontSize: 20))),
                                      SizedBox(
                                         height: 40,
                                         child: Text('Lieu de livraison: ' + (livraison.lieuArrivee),
                                         style: const TextStyle(fontSize: 20))), 
                                      SizedBox(
                                         height: 40,
                                         child: Text('Véhicule: ' + (livraison.categorie),
                                         style: const TextStyle(fontSize: 20))),  
                                     SizedBox(
                                         height: 40, 
                                         child: Text('Statut: ' + (livraison.status),
                                         style: const TextStyle(fontSize: 20)))])),                          
                          
                          SizedBox(
                              height: 50,
                              child: TextButton(style: TextButton.styleFrom(primary: Colors.lightBlue),
                                  child: Text(livraison.status == 'DONE' ?  'cloturé' : 'à cloturer',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 20,
                                          )),
                                   onPressed:  () {},
                                       )
        )]))));
      });
}



