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
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
        children:[
        Row(
        children:[
         Material(
               elevation: 6,
               shape: const CircleBorder(),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               child:  InkWell(
                 splashColor: Colors.greenAccent,
                 onTap: (){} ,
                 child: Ink.image(
                             image: const AssetImage('appel.png'),
                              width: 100 ,
                              height: 100 ,
                              fit: BoxFit.cover,),
                              )
                       ),
         const Spacer(),
         const Text('Recevoir un appel',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,)
        )]),
             

        Row(
        children:[
         Material(
               elevation: 6,
               shape: const CircleBorder(),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               child:  InkWell(
                 splashColor: Colors.greenAccent,
                 onTap: (){} ,
                 child: Ink.image(
                             image: const AssetImage('vocal.png'),
                              width: 100 ,
                              height: 100 ,
                              fit: BoxFit.cover,),
                              )
                       ),
         const Spacer(),
         const Text('Faire un vocal',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,))]),
       
        Row(
        children:[
         Material(
               elevation: 6,
               borderRadius: BorderRadius.circular(20),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               child:  InkWell(
                 splashColor: Colors.black12,
                 onTap: (){} ,
                 child: Ink.image(
                             image: const AssetImage('formulaire.png'),
                              width: 100 ,
                              height: 100 ,
                              fit: BoxFit.cover,),
                              )
                       ),
      
         const Text('Remplir le formulaire',   
                    style: TextStyle(
                    height: 18,  
                    fontSize: 20,
                    ))]),
                   
        ]));
  
  }
}



