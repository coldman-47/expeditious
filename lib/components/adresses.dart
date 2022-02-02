import 'package:flutter/material.dart';
import 'package:nrj_express/api/livraison_service.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:nrj_express/screens/home_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'modal_post_creation.dart';

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
  late String status;
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
                      widget.delivery.status = 'PENDING';
                      var create = await livraisonSrv.create(widget.delivery);
                      if (create == true) {
                        popUpPostCreation(context);
                      }
                    }))
          ],
        ));
  }
}
