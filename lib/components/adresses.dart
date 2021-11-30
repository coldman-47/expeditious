import 'package:flutter/material.dart';
import '../screens/screens.dart';
import 'package:timeline_tile/timeline_tile.dart';

class Adresses extends StatefulWidget {
  final String title = 'Adresses de la livraison';
  final String index = '3';
  final double stepValue = 1;

  const Adresses({Key? key}) : super(key: key);

  @override
  _AdressesState createState() => _AdressesState();
}

class _AdressesState extends State<Adresses> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
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
                    LineStyle(thickness: 1.5, color: Colors.blueGrey),
                isFirst: true,
                alignment: TimelineAlign.center,
                indicatorStyle: const IndicatorStyle(
                    padding: EdgeInsets.symmetric(vertical: 7.5),
                    indicator: Icon(Icons.location_pin, color: Colors.green)),
                startChild: const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            filled: false,
                            labelText: 'Récupération')))),
            TimelineTile(
                beforeLineStyle:
                    LineStyle(thickness: 1.5, color: Colors.blueGrey),
                isLast: true,
                alignment: TimelineAlign.center,
                indicatorStyle: const IndicatorStyle(
                    padding: EdgeInsets.symmetric(vertical: 7.5),
                    indicator: Icon(Icons.location_pin, color: Colors.red)),
                endChild: const Padding(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                        decoration: InputDecoration(
                            alignLabelWithHint: true,
                            filled: false,
                            labelText: 'Livraison')))),
            Container(
                padding: EdgeInsets.all(30),
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecordScreen()));
                    }))
          ],
        ));
  }
}
