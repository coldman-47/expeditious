import 'package:flutter/material.dart';

class Choix extends StatefulWidget {
  final String title = 'Choisir une option';
  final String index = '2';
  final double stepValue = 0.33;

  const Choix({Key? key}) : super(key: key);

  @override
  _ChoixState createState() => _ChoixState();
}

class _ChoixState extends State<Choix> {
 
  @override
  Widget build(BuildContext context) {
    return Container( 
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children:[
        Row(mainAxisAlignment: MainAxisAlignment.start,
        children:[
          ButtonBar(alignment: MainAxisAlignment.start, children: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade100)),
                onPressed: () {},
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/appel.png'),
                            fit: BoxFit.cover)))),
          ]),
          const Text('Recevoir un appel',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,) )]),
             

        Row(mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Material(elevation: 6,
               shape: CircleBorder(),
               clipBehavior: Clip.antiAliasWithSaveLayer,),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade100)),
                onPressed: () {},
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('vocal.png'),
                            fit: BoxFit.cover)))),
             const Text('Faire un vocal',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,))]),
       
        Row(mainAxisAlignment: MainAxisAlignment.start,
        children:[
          const Material(
            elevation: 6,
               shape: CircleBorder(),
               clipBehavior: Clip.antiAliasWithSaveLayer,),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue.shade100)),
                onPressed: () {},
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('formulaire.png'),
                            fit: BoxFit.cover)))),
                    const Text('Remplir le formulaire',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,))
        ])]));
  
  }
}



