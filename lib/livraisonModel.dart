import 'dart:convert';

LivraisonModel livraisonModelFromJson(String str) => LivraisonModel.fromJson(jsonDecode(str));

String livraisonModelToJson(LivraisonModel data) => json.encode(data.toJson());

class LivraisonModel {
   final String client;
   final String lieuDepart;
   final String lieuArrivee;
   final String telephone;

  LivraisonModel({
      required this.client,
      required this.lieuDepart,
      required this.lieuArrivee,
      required this.telephone
    });

  factory LivraisonModel.fromJson(Map<String, dynamic> json) =>  LivraisonModel(
    client : json['client'],
    lieuDepart : json['lieuDepart'],
    lieuArrivee : json['lieuArrivee'],
    telephone : json['telephone'],
  );

  Map<String, dynamic> toJson() => {
    'client' : client,
    'lieuDepart' : lieuDepart,
    'lieuArrivee' : lieuArrivee,
    'telephone' :telephone,
    
  };
}
