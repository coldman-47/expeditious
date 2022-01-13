import 'package:flutter/material.dart';
import 'package:nrj_express/components/adresses.dart';
import 'package:nrj_express/components/categories.dart';
import 'package:nrj_express/components/choix.dart';
import 'package:nrj_express/components/record.dart';
import 'package:nrj_express/models/livraison.dart';
import 'package:nrj_express/screens/layout.dart';

import 'home_screen.dart';

class NewDelivery extends StatelessWidget {
  const NewDelivery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
        title: 'DEMANDER UNE LIVRAISON', child: const LivraisonCtrl());
  }
}

class LivraisonCtrl extends StatefulWidget {
  const LivraisonCtrl({Key? key}) : super(key: key);

  @override
  _LivraisonCtrlState createState() => _LivraisonCtrlState();
}

// double _progress = 0;
// void startTimer() {
//   new Timer.periodic(
//     Duration(seconds: 1),
//     (Timer timer) => setState(
//       () {
//         if (_progress == 1) {
//           timer.cancel();
//         } else {
//           _progress += 0.2;
//         }
//       },
//     ),
//   );
// }
class _LivraisonCtrlState extends State<LivraisonCtrl> {
  late dynamic deliveryStep;
  Livraison livraison = Livraison();
  late String deliveryChoice;

  dynamic _loadStep(int index) {
    setState(() {
      if (index == 1) {
        deliveryStep = Categories(progress: _loadStep, delivery: livraison);
      } else if (index == 2) {
        deliveryStep = Choix(progress: _loadStep);
      } else {
        if (deliveryStep.choice == 'itineraire') {
          deliveryStep = Adresses(delivery: livraison);
        } else if (deliveryStep.choice == 'audio') {
          deliveryStep = Record(delivery: livraison);
        } else if (deliveryStep.choice == 'call') {
          // deliveryStep = popUpPostCreation(context);
        }
      }
    });
  }

  _LivraisonCtrlState() {
    deliveryStep = Categories(progress: _loadStep, delivery: livraison);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: const EdgeInsets.all(10),
          child: Row(children: [
            if (deliveryStep.index > 1)
              IconButton(
                  constraints: const BoxConstraints(),
                  color: Colors.orange,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    _loadStep(deliveryStep.index - 1);
                  })
            else
              const SizedBox(width: 50),
            const SizedBox(width: 16),
            Expanded(
                child: Text(deliveryStep.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54))),
            const SizedBox(width: 16),
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
            )
          ])),
      LinearProgressIndicator(
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          value: deliveryStep.stepValue,
          minHeight: 2),
      SizedBox(
          height: 450,
          child: Container(
              constraints: BoxConstraints.expand(),
              child: Center(child: SingleChildScrollView(child: deliveryStep))))
    ]);
  }
}

popUpPostCreation(context) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Center(
                child: Text(
              'Demande enregistrée',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                  letterSpacing: 0.75),
            )),
            content: Container(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        constraints: const BoxConstraints(
                            maxWidth: double.infinity, maxHeight: 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(45),
                            image: const DecorationImage(
                                image: AssetImage('images/processing.png'),
                                fit: BoxFit.contain))),
                    const Text(
                      'Nous vous contactons dans un instant. Merci.',
                      textAlign: TextAlign.center,
                    )
                  ],
                )),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(Colors.blueGrey[700])),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Center(
                      child: Row(
                    children: const [
                      Spacer(),
                      Text('TERMINER ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Icon(Icons.done),
                      Spacer()
                    ],
                  )))
            ],
          ));
}
