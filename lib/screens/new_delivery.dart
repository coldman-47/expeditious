import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nrj_express/components/adresses.dart';
import 'package:nrj_express/components/vehicles.dart';

class NewDelivery extends StatelessWidget {
  const NewDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Image(
                    image: AssetImage('images/logo.png'),
                    fit: BoxFit.contain,
                    height: 60,
                    width: 250),
                elevation: 0),
            body: Container(
                constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25), //.all(25),
                child: Container(
                    padding: EdgeInsets.all(5),
                    width: 350,
                    child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                              child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[900],
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 150,
                                  width: 350,
                                  child: const Text('DEMANDER UNE LIVRAISON',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold)))),
                          Positioned(
                              top: 60,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: LivraisonCtrl()),
                              ))
                        ])))));
  }
}

class LivraisonCtrl extends StatefulWidget {
  const LivraisonCtrl({Key? key}) : super(key: key);

  @override
  _LivraisonCtrlState createState() => _LivraisonCtrlState();
}

class _LivraisonCtrlState extends State<LivraisonCtrl> {
  double _progress = 0;

  void startTimer() {
    new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_progress == 1) {
            timer.cancel();
          } else {
            _progress += 0.2;
          }
        },
      ),
    );
  }

  late dynamic deliveryStep;

  _loadStep(int index) {
    setState(() {
      if (index == 1) {
        deliveryStep = Vehicles(progress: _loadStep);
      } else if (index == 3) {
        deliveryStep = const Adresses();
      }
    });
  }

  _LivraisonCtrlState() {
    deliveryStep = Vehicles(progress: _loadStep);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(10),
          child: Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blueGrey[100],
              child: CircleAvatar(
                  backgroundColor: Colors.blueGrey[900],
                  child: Text(deliveryStep.index.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22))),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(deliveryStep.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54))),
          ])),
      LinearProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          value: deliveryStep.stepValue,
          minHeight: 2),
      Container(
          height: 450,
          child: Center(child: SingleChildScrollView(child: deliveryStep)))
    ]);
  }
}
