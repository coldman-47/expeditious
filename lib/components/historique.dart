import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:nrj_express/api/categorie_service.dart';
import 'package:nrj_express/api/client_service.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:nrj_express/screens/layout.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

int currentPage = 1;
late int numPages;
List<Livraison> livraisons = [];
bool loaded = false;

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

  Future<List<Livraison>> fetchLivraison() async {
    ClientService clientSrv = ClientService();
    loaded = false;
    var historique = await clientSrv.historiqueLivraison(page: currentPage);
    // numPages = historique["totalPages"];
    return getLivraison(historique);
  }

  List<Livraison> getLivraison(res) {
    final parseLivraisons = res["data"];
    numPages = res["totalPages"];
    if (parseLivraisons.length > 0) {
      for (var i in parseLivraisons) {
        livraisons.add(Livraison.fromJson(i));
      }
      setState(() {
        loaded = true;
      });
    }
    return livraisons;
  }

  @override
  void initState() {
    _loadCategories();
    fetchLivraison();
    super.initState();
    listenToDeliverUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'Historique des livraisons',
        child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(12.5),
                height: 500,
                child: loaded
                    ? ListView.builder(
                        itemCount: livraisons.length,
                        itemBuilder: (context, i) {
                          if (i + 1 >= livraisons.length &&
                              currentPage < numPages) {
                            currentPage++;
                            fetchLivraison();
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.orange,
                            ));
                          }
                          var livraison = livraisons[i];
                          for (var categorie in categories) {
                            if (livraison.categorie == categorie['_id']) {
                              livraison.categorie = categorie['label'];
                            }
                          }
                          return Card(
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              elevation: 0,
                              color: livraison.status == 'NEW'
                                  ? Colors.orange[50]
                                  : livraison.status != 'DONE'
                                      ? Colors.lightBlue[50]
                                      : Colors.green[50],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          minVerticalPadding: 15,
                                          isThreeLine: true,
                                          dense: true,
                                          subtitle: Text(
                                              DateFormat('dd/MM/yyyy à HH:mm')
                                                  .format(
                                                DateTime.parse(
                                                    livraison.created),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.grey)),
                                          onTap: () => _ShowDialogFun(
                                              context, livraison),
                                          title: livraison.status != 'NEW'
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      livraison.lieuDepart !=
                                                              null
                                                          ? capitalize(livraison
                                                              .lieuDepart!)
                                                          : '',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors
                                                              .blueGrey[700]),
                                                    ),
                                                    const Icon(Icons
                                                        .arrow_forward_sharp),
                                                    Text(
                                                      livraison.lieuArrivee !=
                                                              null
                                                          ? capitalize(livraison
                                                              .lieuArrivee!)
                                                          : '',
                                                      style: const TextStyle(
                                                          color: Colors.orange,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    )
                                                  ],
                                                )
                                              : Text(
                                                  'Demande en attente de prise en charge',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .blueGrey[400])),
                                          trailing: Icon(livraison.status ==
                                                  'DONE'
                                              ? Icons.check
                                              : Icons.hourglass_bottom_rounded),
                                          iconColor: livraison.status == 'DONE'
                                              ? Colors.lightGreen[700]
                                              : Colors.amber)
                                    ],
                                  )));
                        })
                    : const Center(
                        child: CircularProgressIndicator(
                        color: Colors.orange,
                      )))));
  }

  void listenToDeliverUpdates() {
    try {
      IO.Socket socket = IO.io(dotenv.env['API_URL'],
          OptionBuilder().setTransports(['websocket']).build());
      socket.on('api/livraison/updated', (data) {
        int idx =
            livraisons.indexWhere((livraison) => livraison.id == data['_id']);
        if (idx != -1) {
          setState(() {
            livraisons[idx] = Livraison.fromJson(data);
          });
        }
      });
    } catch (e) {
      print(e);
    }
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
                child: Card(
                    child: Container(
                        padding: const EdgeInsets.all(25),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 400,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Text('Détails de la demande',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600))),
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.425,
                                          child: Column(
                                            children: [
                                              TimelineTile(
                                                beforeLineStyle:
                                                    const LineStyle(
                                                        thickness: 1.5,
                                                        color: Colors.blueGrey),
                                                isFirst: true,
                                                alignment: TimelineAlign.center,
                                                indicatorStyle:
                                                    const IndicatorStyle(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 7.5),
                                                        indicator: Icon(
                                                            Icons.location_pin,
                                                            color:
                                                                Colors.green)),
                                                startChild: Text(
                                                  livraison.lieuDepart
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.blueGrey),
                                                ),
                                              ),
                                              TimelineTile(
                                                  beforeLineStyle:
                                                      const LineStyle(
                                                          thickness: 1.5,
                                                          color:
                                                              Colors.blueGrey),
                                                  isLast: true,
                                                  alignment:
                                                      TimelineAlign.center,
                                                  indicatorStyle:
                                                      const IndicatorStyle(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          indicator: Icon(
                                                              Icons
                                                                  .location_pin,
                                                              color:
                                                                  Colors.red)),
                                                  startChild: Text(
                                                    livraison.lieuArrivee
                                                        .toUpperCase(),
                                                    style: const TextStyle(
                                                        color: Colors.blueGrey),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                height: 60,
                                                child: Column(children: [
                                                  const Text(
                                                    'Catégorie :',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ),
                                                  Icon(
                                                      livraison.categorie ==
                                                              'scooter'
                                                          ? Icons
                                                              .delivery_dining_sharp
                                                          : (livraison.categorie ==
                                                                  'tricycle'
                                                              ? Icons
                                                                  .bike_scooter_sharp
                                                              : Icons
                                                                  .local_shipping_sharp),
                                                      size: 30,
                                                      color:
                                                          Colors.blueGrey[800])
                                                ])),
                                            SizedBox(
                                                height: 60,
                                                child: Column(
                                                  children: [
                                                    const Text('État :',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.grey,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline)),
                                                    Icon(
                                                        livraison.status ==
                                                                'PENDING'
                                                            ? Icons
                                                                .pending_actions_sharp
                                                            : (livraison.categorie ==
                                                                    'NEW'
                                                                ? Icons
                                                                    .query_builder_sharp
                                                                : Icons
                                                                    .check_circle_outline_sharp),
                                                        size: 30,
                                                        color: Colors.orange)
                                                  ],
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                        'Créée le ' +
                                            DateFormat('dd/MM/yyyy à HH:mm')
                                                .format(
                                              DateTime.parse(livraison.created),
                                            ),
                                        style:
                                            const TextStyle(color: Colors.grey))
                                  ])),
                              SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.blueGrey[700]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            livraison.status == 'DONE'
                                                ? 'cloturé'
                                                : 'ACCUSÉ DE RECEPTION ',
                                            textAlign: TextAlign.center,
                                            style: const TextStyle()),
                                        Icon(Icons.check)
                                      ],
                                    ),
                                    onPressed: () {},
                                  ))
                            ])))));
      });
}

capitalize(String word) {
  return word[0].toUpperCase() + word.substring(1).toLowerCase();
}
