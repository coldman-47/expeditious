import 'package:flutter/material.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nrj_express/api/interceptor/access_token.dart';
import 'package:nrj_express/components/historique.dart';
import 'package:nrj_express/screens/new_delivery.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  InterceptedClient httpCli = clientIntercepted;
}

class _HomeScreenState extends State<HomeScreen> {
  void getMicPermission() async {
    if (await Permission.microphone.isGranted) {
      await Permission.microphone.request();
    }
  }

  @override
  void initState() {
    getMicPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/bg.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              title: const Image(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.contain,
                  height: 60,
                  width: 250),
              elevation: 0),
          body: Container(
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 25), //.all(25),
              child: Container(
                  padding: const EdgeInsets.all(5),
                  width: 350, //.all(25),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade100)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NewDelivery()));
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              SizedBox(
                                  height: 210,
                                  width: 230,
                                  child: Container(
                                    height: 150,
                                    width: 175,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'images/demande.png'),
                                            fit: BoxFit.cover)),
                                  )),
                              const Text('Nouvelle demande',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 3.0),
                                        Shadow(
                                          offset: Offset(5.0, 7.5),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(150, 0, 0, 0),
                                        ),
                                      ]))
                            ])),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue.shade100),
                                maximumSize: MaterialStateProperty.all<Size>(
                                    const Size.fromWidth(270))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Historique()));
                            },
                            child:
                                Stack(alignment: Alignment.center, children: [
                              SizedBox(
                                  height: 210,
                                  width: 230,
                                  child: Container(
                                      height: 150,
                                      width: 175,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/historique.png'),
                                              fit: BoxFit.cover)))),
                              const Text('Historique des livraisons',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 3.0),
                                        Shadow(
                                          offset: Offset(5.0, 7.5),
                                          blurRadius: 3.0,
                                          color: Color.fromARGB(150, 0, 0, 0),
                                        )
                                      ]))
                            ]))
                      ]))),
        ));
  }
}
