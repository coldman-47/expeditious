import 'package:flutter/material.dart';
import '../components/components.dart';

class RecordScreen extends StatefulWidget {
  final String title = 'Envoyez les adresses de la livraison par message vocal';
  final int index = 3;
  final double stepValue = 0.33;

  const RecordScreen({Key? key}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
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
                    height: 75,
                    width: 250),
                centerTitle: true,
                elevation: 0),
            body: Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 25), //.all(25),
                child: Container(
                    padding: const EdgeInsets.all(5),
                    width: 350,
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
                                    child: Text('')),
                              ))
                        ])))));
  }
}
