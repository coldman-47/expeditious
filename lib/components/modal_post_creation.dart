import 'package:flutter/material.dart';
import 'package:nrj_express/screens/home_screen.dart';

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
