import 'package:flutter/material.dart';

class Choix extends StatefulWidget {
  final String title = 'Choisir une option';
  final int index = 2;
  final double stepValue = 0.66;
  final ValueChanged<int> progress;

  const Choix({Key? key, required this.progress}) : super(key: key);

  @override
  _ChoixState createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ButtonBar(alignment: MainAxisAlignment.center, children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade100)),
            onPressed: () {
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
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/itineraire.png'),
                                fit: BoxFit.cover)))),
                const Text('Remplir le formulaire',
                    style: TextStyle(
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
            )),
        const SizedBox(height: 20),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade100)),
            onPressed: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 150,
                    width: 200,
                    child: Container(
                        constraints: const BoxConstraints.expand(),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/audio.png'),
                                fit: BoxFit.cover)))),
                const Text('Enregistrer un audio',
                    style: TextStyle(
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
            )),
        const SizedBox(height: 20),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue.shade100)),
            onPressed: () {},
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    height: 150,
                    width: 200,
                    child: Container(
                        constraints: const BoxConstraints.expand(),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/call.png'),
                                fit: BoxFit.cover)))),
                const Text('Recevoir un appel',
                    style: TextStyle(
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
            )),
      ]),
    );
    // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    //   const Material(
    //     elevation: 6,
    //     shape: CircleBorder(),
    //     clipBehavior: Clip.antiAliasWithSaveLayer,
    //   ),
    //   ElevatedButton(
    //       style: ButtonStyle(
    //           backgroundColor:
    //               MaterialStateProperty.all<Color>(Colors.blue.shade100)),
    //       onPressed: () {},
    //       child: Container(
    //           height: 100,
    //           width: 100,
    //           decoration: const BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage('images/vocal.png'),
    //                   fit: BoxFit.cover)))),
    //   const Text('Faire un vocal',
    //       style: TextStyle(
    //         height: 18,
    //         fontSize: 20,
    //       ))
    // ]),
    // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    //   const Material(
    //     elevation: 6,
    //     shape: CircleBorder(),
    //     clipBehavior: Clip.antiAliasWithSaveLayer,
    //   ),
    //   ElevatedButton(
    //       style: ButtonStyle(
    //           backgroundColor:
    //               MaterialStateProperty.all<Color>(Colors.blue.shade100)),
    //       onPressed: () {},
    //       child: Container(
    //           height: 100,
    //           width: 100,
    //           decoration: const BoxDecoration(
    //               image: DecorationImage(
    //                   image: AssetImage('images/formulaire.png'),
    //                   fit: BoxFit.cover)))),
    //   const Text('Remplir le formulaire',
    //       style: TextStyle(
    //         height: 18,
    //         fontSize: 20,
    //       ))
    // ])
  }
}
