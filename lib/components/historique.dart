import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nrj_express/api/categorie_service.dart';
import 'package:nrj_express/api/client_service.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:nrj_express/screens/layout.dart';
import 'package:path/path.dart';

Future<List<Livraison>> fetchLivraison() async {
  ClientService clientSrv = ClientService();
  var historique =
      await clientSrv.historiqueLivraison('61c098a8ba066d250792a425');
  return getLivraison(historique);
}

List<Livraison> getLivraison(res) {
  List<Livraison> livraisons = [];
  final parseLivraisons = res["data"];
  if (parseLivraisons.length > 0) {
    for (var i in parseLivraisons) {
      livraisons.add(Livraison.fromJson(i));
    }
  }
  return livraisons;
}

class Historique extends StatefulWidget {
  const Historique({
    Key? key,
  }) : super(key: key);
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
    return Layout(
        title: 'Historique des livraisons',
        child: SingleChildScrollView(
            child: Container(
                height: 500,
                child: FutureBuilder<List<Livraison>>(
                    future: fetchLivraison(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              var livraison = snapshot.data[i];
                              for (var categorie in categories) {
                                if (livraison.categorie == categorie['_id']) {
                                  livraison.categorie = categorie['label'];
                                }
                              }
                              return Card(
                                  child: Column(
                                children: [
                                  ListTile(
                                      onTap: () =>
                                          _ShowDialogFun(context, livraison),
                                      title: Row(
                                        children: [
                                          Text(
                                            livraison.lieuDepart.toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.blueGrey[700]),
                                          ),
                                          const Icon(Icons.arrow_right_sharp),
                                          Text(
                                            livraison.lieuArrivee.toUpperCase(),
                                            style:
                                                TextStyle(color: Colors.orange),
                                          )
                                        ],
                                      ),
                                      trailing: Icon(livraison.status == 'DONE'
                                          ? Icons.check
                                          : Icons.hourglass_bottom_rounded),
                                      iconColor: livraison.status == 'DONE'
                                          ? Colors.lightGreen[700]
                                          : Colors.yellowAccent[700]),
                                  Text(
                                      DateFormat('yyyy/MM/dd à hh:mm').format(
                                        DateTime.parse(livraison.created),
                                      ),
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ));
                            });
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.orange,
                        ));
                      }
                    }))));
  }
}

// ignore: non_constant_identifier_names
_ShowDialogFun(context, livraison) {
  return showDialog(
      context: context,
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
                          Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                        height: 40,
                                        child: Text(
                                            'Lieu de récupération: ' +
                                                (livraison.lieuDepart),
                                            style:
                                                const TextStyle(fontSize: 20))),
                                    SizedBox(
                                        height: 40,
                                        child: Text(
                                            'Lieu de livraison: ' +
                                                (livraison.lieuArrivee),
                                            style:
                                                const TextStyle(fontSize: 20))),
                                    SizedBox(
                                        height: 40,
                                        child: Text(
                                            'Véhicule: ' +
                                                (livraison.categorie),
                                            style:
                                                const TextStyle(fontSize: 20))),
                                    SizedBox(
                                        height: 40,
                                        child: Text(
                                            'Statut: ' + (livraison.status),
                                            style:
                                                const TextStyle(fontSize: 20)))
                                  ])),
                          SizedBox(
                              height: 50,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    primary: Colors.lightBlue),
                                child: Text(
                                    livraison.status == 'DONE'
                                        ? 'cloturé'
                                        : 'à cloturer',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 20,
                                    )),
                                onPressed: () {},
                              ))
                        ]))));
      });
}
