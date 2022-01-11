import 'package:flutter/material.dart';
import 'package:nrj_express/api/code_confirmation.dart';
import 'package:nrj_express/screens/home_screen.dart';

class UserCodeForm extends StatefulWidget {
  final bool page;
  final String telephone;
  final ValueChanged<bool> loadPage;
  const UserCodeForm(
      {Key? key,
      required this.page,
      required this.loadPage,
      required this.telephone})
      : super(key: key);

  @override
  _UserCodeFormState createState() => _UserCodeFormState();
}

class _UserCodeFormState extends State<UserCodeForm> {
  final codeConfirmationService = CodeConfirmation();
  final codeCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var transparent = Colors.transparent;
    return Scaffold(
      appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                widget.loadPage(true);
              },
              icon: const Icon(Icons.arrow_back),
              alignment: Alignment.topLeft,
            );
          }),
          backgroundColor: transparent,
          elevation: 0),
      backgroundColor: transparent,
      body: Center(
          child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
            Positioned(
                top: 240,
                width: 340,
                height: 325,
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
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
                                    child: Text('CODE',
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 32.5,
                                            letterSpacing: 1.75,
                                            fontWeight: FontWeight.bold))),
                                const Spacer(),
                                TextFormField(
                                  controller: codeCtrl,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                      filled: false,
                                      labelText: 'Code de confirmation'),
                                ),
                                const Spacer(flex: 1),
                                TextButton(
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
                                    codeConfirmationService
                                        .confirm(
                                            widget.telephone, codeCtrl.text)
                                        .then((value) => {
                                              if (value)
                                                {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen()))
                                                }
                                            });
                                  },
                                ),
                                const Spacer()
                              ],
                            ))
                          ],
                        )))),
            Positioned(
                width: 340,
                height: 275,
                child: Card(
                    elevation: 10,
                    color: Colors.grey[350],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: double.infinity, maxHeight: 250),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            image: const DecorationImage(
                                image: AssetImage('images/2fa.png'),
                                fit: BoxFit.cover))))),
          ])),
    );
  }
}
