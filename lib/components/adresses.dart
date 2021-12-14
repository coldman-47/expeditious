import 'package:flutter/material.dart';
import 'package:nrj_express/api/livraison_service.dart';
import 'package:nrj_express/models/livraison.dart';
import '../screens/screens.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Adresses extends StatefulWidget {
  final String title = 'Adresses de la livraison';
  final int index = 3;
  final double stepValue = 1;
  final Livraison delivery;

  const Adresses({Key? key, required this.delivery}) : super(key: key);

  @override
  _AdressesState createState() => _AdressesState();
}

class _AdressesState extends State<Adresses> {
  final adresseLivraisonCtrl = TextEditingController();
  final adresseRecuperationCtrl = TextEditingController();
  final livraisonSrv = LivraisonService();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Uniquement sur Dakar!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                    color: Colors.orange[700])),
            TimelineTile(
                beforeLineStyle:
                    const LineStyle(thickness: 1.5, color: Colors.blueGrey),
                isFirst: true,
                alignment: TimelineAlign.center,
                indicatorStyle: const IndicatorStyle(
                    padding: EdgeInsets.symmetric(vertical: 7.5),
                    indicator: Icon(Icons.location_pin, color: Colors.green)),
                startChild: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                        controller: adresseRecuperationCtrl,
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            filled: false,
                            labelText: '* Récupération')))),
            TimelineTile(
                beforeLineStyle:
                    const LineStyle(thickness: 1.5, color: Colors.blueGrey),
                isLast: true,
                alignment: TimelineAlign.center,
                indicatorStyle: const IndicatorStyle(
                    padding: EdgeInsets.symmetric(vertical: 7.5),
                    indicator: Icon(Icons.location_pin, color: Colors.red)),
                endChild: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                        controller: adresseLivraisonCtrl,
                        decoration: const InputDecoration(
                            alignLabelWithHint: true,
                            filled: false,
                            labelText: '* Livraison')))),
            const TextField(
              maxLines: 4,
              decoration:
                  InputDecoration(labelText: 'Commentaire', filled: true),
            ),
            Container(
                padding: const EdgeInsets.all(30),
                child: TextButton(
                    child: const Text('CONFIRMER'),
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 20.5,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w600),
                        minimumSize: const Size.fromHeight(60),
                        padding: const EdgeInsets.all(20),
                        backgroundColor: Colors.orange,
                        primary: Colors.white),
                    onPressed: () async {
                      widget.delivery.lieuDepart = adresseRecuperationCtrl.text;
                      widget.delivery.lieuArrivee = adresseLivraisonCtrl.text;
                      popUpPostCreation(context);
                      // await livraisonSrv.create(widget.delivery);
                    }))
          ],
        ));
  }
}

popUpPostCreation(context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Center(
                child: Text(
              'Demande enregistrée',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  letterSpacing: 0.75),
            )),
            content: Container(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        constraints: const BoxConstraints(
                            maxWidth: double.infinity, maxHeight: 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: const DecorationImage(
                                image: AssetImage('images/processing.png'),
                                fit: BoxFit.contain))),
                    const Text(
                      'Nous vous contactons dans un instant. Merci.',
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueGrey[700])),
                  onPressed: () {},
                  child: Center(
                      child: Row(
                    children: const [
                      Spacer(),
                      Text('TERMINER ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Icon(Icons.done),
                      Spacer()
                    ],
                  )))
            ],
          ));
}
