import 'package:flutter/material.dart';

class Vehicles extends StatefulWidget {
  final String title = 'Type de transport pour votre colis';
  final int index = 1;
  final double stepValue = 0.25;

  const Vehicles({
    Key? key,
    title,
    index,
    stepValue,
  }) : super(key: key);

  @override
  _VehiclesState createState() => _VehiclesState();
}

class _VehiclesState extends State<Vehicles> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
