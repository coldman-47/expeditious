import 'dart:ffi';
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
  get child => null;

  @override
  Widget build(BuildContext context) {
    return Column(
        children:[
              Expanded(
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink.image(
                                  image: const AssetImage('Appel.png'),
                                  height: 100 ,
                                  width: 100 ,
                                  fit: BoxFit.cover,),
                      const SizedBox(height:6),
                      const Spacer(),
                      const Text('Recevoir un appel', style: TextStyle(fontSize: 28,) ,)
                     ] )
                               ),
                              
                      ),
    
              Expanded(
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink.image(
                                  image: const AssetImage('vocal.png'),
                                  height: 100 ,
                                  width: 100 ,
                                  fit: BoxFit.cover,),
                      const SizedBox(height:6),
                      const Spacer(),
                      const Text('Faire un vocal', style: TextStyle(fontSize: 28,) ,)
                     ] )
                               ),
                            
                      ), 
               Expanded(
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Ink.image(
                                  image: const AssetImage('formulaire.png'),
                                  height: 100 ,
                                  width: 100 ,
                                  fit: BoxFit.cover,),
                      const SizedBox(height:6),
                      const Spacer(),
                      const Text('Remplir le formulaire', style: TextStyle(fontSize: 28,) ,)
                     ] )
                               ),
                            
     
     ) ] 
    );
       
                     
  }
}



