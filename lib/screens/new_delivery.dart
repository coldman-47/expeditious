import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
            appBar: AppBar(
                title: const Text('NRJExpress'),
                centerTitle: true,
                elevation: 0),
            body: Container(
                color: Colors.transparent,
                constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.all(25),
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: 500,
                    child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                              child: Container(
                                  padding: EdgeInsets.all(35),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[600],
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 150,
                                  width: 400,
                                  child: const Text('DEMANDER UNE LIVRAISON',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)))),
                          Positioned(
                              top: 85,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                    height: 500,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: livraisonCtrl()),
                              ))
                        ])))));
  }
}

Widget livraisonCtrl() {
  Widget screenChild = Vehicles();
  var log = new Logger();
  log.d(screenChild.toString());
  return Container(
      padding: EdgeInsets.all(15),
      child: Column(children: [
        Row(children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.amber[100],
            child: CircleAvatar(
                backgroundColor: Colors.amber[500], child: const Text('1')),
          ),
          const SizedBox(width: 16),
          const Text('Type de transport pour votre colis',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
        ]),
        const Divider(color: Colors.transparent),
        const LinearProgressIndicator(value: 0.25, color: Colors.red)
      ]));
}
