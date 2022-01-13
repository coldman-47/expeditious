import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nrj_express/api/categorie_service.dart';
import 'package:nrj_express/api/client_service.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:nrj_express/screens/layout.dart';
import 'package:timeline_tile/timeline_tile.dart';

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

  Future<List<Livraison>> fetchLivraison({int numPage = 1}) async {
    ClientService clientSrv = ClientService();
    loaded = false;
    var historique = await clientSrv.historiqueLivraison(page: numPage);
    // numPages = historique["totalPages"];
    return getLivraison(historique);
  }

  List<Livraison> getLivraison(res) {
    final parseLivraisons = res["data"];
    numPages = res["totalPages"];
    if (parseLivraisons.length > 0) {
      print(parseLivraisons.length);
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
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'Historique des livraisons',
        child: SingleChildScrollView(
            child: SizedBox(
                height: 500,
                child: loaded
                    ? ListView.builder(
                        itemCount: livraisons.length,
                        itemBuilder: (context, i) {
                          if (i + 1 >= livraisons.length &&
                              currentPage <= numPages) {
                            currentPage++;
                            fetchLivraison(numPage: currentPage);
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
                              child: Column(
                            children: [
                              ListTile(
                                  onTap: () =>
                                      _ShowDialogFun(context, livraison),
                                  title: Row(
                                    children: [
                                      Text(
                                        livraison.lieuDepart != null
                                            ? livraison.lieuDepart!
                                                .toUpperCase()
                                            : '',
                                        style: TextStyle(
                                            color: Colors.blueGrey[700]),
                                      ),
                                      const Icon(Icons.arrow_right_sharp),
                                      Text(
                                        livraison.lieuArrivee != null
                                            ? livraison.lieuArrivee!
                                                .toUpperCase()
                                            : '',
                                        style: const TextStyle(
                                            color: Colors.orange),
                                      )
                                    ],
                                  ),
                                  trailing: Icon(livraison.status == 'DONE'
                                      ? Icons.check
                                      : Icons.hourglass_bottom_rounded),
                                  iconColor: livraison.status == 'DONE'
                                      ? Colors.lightGreen[700]
                                      : Colors.amber),
                              Text(
                                  DateFormat('dd/MM/yyyy à HH:mm').format(
                                    DateTime.parse(livraison.created),
                                  ),
                                  style: const TextStyle(color: Colors.grey))
                            ],
                          ));
                        })
                    : const Center(
                        child: CircularProgressIndicator(
                        color: Colors.orange,
                      )))));
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
