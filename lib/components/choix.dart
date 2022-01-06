import 'package:flutter/material.dart';

class Choix extends StatefulWidget {
  final String title = 'Choisir une option';
  final int index = 2;
  final double stepValue = 0.66;
  final ValueChanged<int> progress;
  late String choice;

  Choix({Key? key, required this.progress}) : super(key: key);

  @override
  _ChoixState createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {
  @override
  Widget build(BuildContext context) {
    var choices = [
      {'choix': 'itineraire', 'text': 'Remplir le formulaire'},
      {'choix': 'audio', 'text': 'Enregistrer un audio'},
      {'choix': 'call', 'text': 'Recevoir un appel'},
    ];
    return Container(
      padding: const EdgeInsets.all(20),
      child: ButtonBar(alignment: MainAxisAlignment.center, children: [
        for (var choice in choices)
          Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue.shade100)),
                  onPressed: () {
                    widget.choice = '${choice["choix"]}';
                    widget.progress(3);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                          height: 150,
                          width: 200,
                          child: Container(
                              constraints: const BoxConstraints.expand(),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'images/${choice["choix"]}.png'),
                                      fit: BoxFit.cover)))),
                      Text('${choice["text"]}',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 0),
                                  blurRadius: 3.0,
                                ),
                                Shadow(
                                  offset: Offset(5.0, 7.5),
                                  blurRadius: 3.0,
                                  color: Color.fromARGB(150, 0, 0, 0),
                                ),
                              ]))
                    ],
                  )))
      ]),
    );
  }
}
