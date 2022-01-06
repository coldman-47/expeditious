// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nrj_express/api/interceptor/access_token.dart';
import 'package:nrj_express/components/historique.dart';
import 'package:nrj_express/screens/new_delivery.dart';

class MesDemandes extends StatefulWidget {
  final String label;
  MesDemandes({Key? key, required this.label}) : super(key: key);

  @override
  _MesDemandesState createState() => _MesDemandesState();
  InterceptedClient httpCli = clientIntercepted;
}
class _MesDemandesState extends State<MesDemandes> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Image(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.contain,
                  height: 60,
                  width: 250),
              elevation: 0),
          body: Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 25), //.all(25),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 350, //.all(25),
                  child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[900],
                                    borderRadius: BorderRadius.circular(15)),
                                height: 150,
                                width: 350,
                                child: const Text('MES DEMANDES',
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
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(20),
                                        child: ButtonBar(
                                            alignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .blue
                                                                  .shade100)),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Historique()));},
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        SizedBox(
                                                            height: 210,
                                                            width: 230,
                                                            child: Container(
                                                                height: 150,
                                                                width: 175,
                                                                decoration: const BoxDecoration(
                                                                    image: DecorationImage(
                                                                        image: AssetImage(
                                                                            'images/historiq.png'),
                                                                        fit: BoxFit
                                                                            .cover)))),
                                                        const Text(
                                                            'Historique des livraisons',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                shadows: [
                                                                  Shadow(
                                                                      offset:Offset(0,0),
                                                                      blurRadius:3.0),
                                                                  Shadow(
                                                                    offset:
                                                                        Offset( 5.0,7.5),
                                                                    blurRadius:3.0,
                                                                    color: Color.fromARGB(
                                                                            150,0,0,0),
                                                                  )
                                                                ]))
                                                      ])),
                                              const SizedBox(height: 25),
                                              ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all<Color>(Colors
                                                                  .blue
                                                                  .shade100)),
                                                  onPressed: () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const NewDelivery()));
                                                  },
                                                  child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        SizedBox(
                                                            height: 210,
                                                            width: 230,
                                                            child: Container(
                                                              height: 150,
                                                              width: 175,
                                                              decoration: const BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: AssetImage(
                                                                          'images//delivery.jpg'),
                                                                      fit: BoxFit
                                                                          .cover)),
                                                            )),
                                                        const Text(
                                                            'Nouvelle demande',
                                                            style: TextStyle(
                                                                fontSize: 22,
                                                                color: Colors.white,
                                                                fontWeight:FontWeight.bold,
                                                                shadows: [
                                                                  Shadow(
                                                                      offset:
                                                                          Offset( 0,0),
                                                                      blurRadius:3.0),
                                                                  Shadow(
                                                                    offset:
                                                                        Offset(5.0,7.5),
                                                                    blurRadius:3.0,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            150,0,0,0),
                                                                  ),
                                                                ]))
                                                      ]))
                                            ])))))
                      ]))),
        ));
  }
}
