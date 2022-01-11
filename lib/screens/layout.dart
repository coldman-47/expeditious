import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  String title = '';
  final Widget child;
  Layout({Key? key, required this.title, required this.child})
      : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
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
                    width: 350,
                    child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Positioned(
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey[900],
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 150,
                                  width: 350,
                                  child: Text(widget.title,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          letterSpacing: 1,
                                          fontWeight: FontWeight.bold)))),
                          Positioned(
                              top: 60,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: widget.child),
                              ))
                        ])))));
  }
}
