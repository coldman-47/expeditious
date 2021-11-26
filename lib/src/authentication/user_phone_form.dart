import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserPhoneForm extends StatefulWidget {
  final bool page;
  final ValueChanged<bool> loadPage;
  const UserPhoneForm({Key? key, required this.page, required this.loadPage})
      : super(key: key);

  @override
  _UserPhoneFormState createState() => _UserPhoneFormState();
}

class _UserPhoneFormState extends State<UserPhoneForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
          Positioned(
              top: 300,
              width: 340,
              height: 325,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: double.infinity, maxHeight: 250),
                      margin: const EdgeInsets.all(25),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(),
                              const Center(
                                  child: Text('Téléphone',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 32.5,
                                          letterSpacing: 1.75,
                                          fontWeight: FontWeight.bold))),
                              const Spacer(),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    filled: false,
                                    labelText: 'Numéro de téléphone'),
                              ),
                              const Spacer(flex: 1),
                              TextButton(
                                child: const Text('ENVOYER'),
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
                                  widget.loadPage(false);
                                },
                              ),
                              const Spacer()
                            ],
                          ))
                        ],
                      )))),
          Positioned(
              top: 65,
              width: 340,
              height: 275,
              child: Card(
                  elevation: 10,
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  child: Container(
                      constraints: const BoxConstraints(
                          maxWidth: double.infinity, maxHeight: 250),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          image: const DecorationImage(
                              image: AssetImage('images/smartphone.png'),
                              fit: BoxFit.cover))))),
        ]));
  }
}
