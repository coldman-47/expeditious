import 'package:flutter/material.dart';
import 'package:nrj_express/api/livraison_service.dart';
import 'package:nrj_express/components/adresses.dart';
import 'package:nrj_express/models/livraison.dart';

class Call extends StatefulWidget {
  final String title = 'Soumettre la demande';
  final int index = 3;
  final double stepValue = 1;
  final Livraison delivery;

 const Call({Key? key, required this.delivery, }) : super(key: key);

  @override
  _CallState createState() => _CallState();
}
class _CallState extends State<Call> {
  late String status ;
  LivraisonService livraisonSrv = LivraisonService();


@override
Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
             Positioned(
              child: Container(
                    height: 260,
                    width: 300,
                    decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: const DecorationImage(
                              image: AssetImage('images/step1.jpg'),
                              fit: BoxFit.cover)))),

            const SizedBox(),
            TextButton(
                child: const Text('SOUMETTRE'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20.5,
                          letterSpacing: 2,
                            fontWeight: FontWeight.w600),
                                 minimumSize: const Size.fromHeight(60),
                                    padding: const EdgeInsets.all(20),
                                      backgroundColor: Colors.amber,
                                          primary: Colors.white),
                                onPressed: () async {
                                  widget.delivery.status = 'NEW';
                                  var create = await livraisonSrv.create(widget.delivery);
                                  if (create == true) {
                                 popUpPostCreation(context);
                             }
                           },
                         )                
                     ]));
                   }
                 }





























