import 'dart:ffi';

import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  final String title = 'Type de transport pour votre colis';
  final String index = '1';
  final double stepValue = 0.33;

  Vehicles({Key? key}) : super(key: key);

  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () {},
                child: Container(
                    height: 150,
                    width: 175,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/bike.png'),
                            fit: BoxFit.contain)))),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                    height: 150,
                    width: 175,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/tricycle.png'),
                            fit: BoxFit.contain)))),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {},
                child: Container(
                    height: 150,
                    width: 175,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/van.png'),
                            fit: BoxFit.contain)))),
          ])
        ]));
  }
}
