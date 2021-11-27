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
            backgroundColor: Colors.transparent,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: const Text('NRJExpress'),
                centerTitle: true,
                elevation: 0),
            body: Container(
                constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.all(25),
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
                                      color: Colors.orange[600],
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 150,
                                  width: 350,
                                  child: const Text('DEMANDER UNE LIVRAISON',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)))),
                          Positioned(
                              top: 60,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                    height: 500,
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
  @override
  Widget build(BuildContext context) {
    late Vehicles vehic;

    vehic = Vehicles();

    return SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(children: [
          Row(children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.amber[100],
              child: CircleAvatar(
                  backgroundColor: Colors.amber[500], child: Text(vehic.index)),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Text(vehic.title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
          ]),
          const Divider(color: Colors.transparent),
          LinearProgressIndicator(value: vehic.stepValue, color: Colors.red),
          vehic
        ]));
  }
}
