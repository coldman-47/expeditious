import 'dart:convert';


AllLivraison allLivraisonFromJson(String str) =>
    AllLivraison.fromJson(json.decode(str));

String allLivraisonToJson(AllLivraison data) => json.encode(data.toJson());

class AllLivraison {
  String id;
  List<Livraison> livraisons;

  AllLivraison({
    required this.id,
    required this.livraisons,
  });

  factory AllLivraison.fromJson(Map<String, dynamic> json) => AllLivraison(
        id: json["id"],
        livraisons: List<Livraison>.from(
            json["livraisons"].map((x) => Livraison.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "livraisons": List<dynamic>.from(livraisons.map((x) => x.toJson())),
      };
}

class Livraison {
  String? client;
  String? lieuDepart;
  String? lieuArrivee;
  String? categorie;
  String? audio;
  String? telephone;
  String? dateLivraison;
  String? status;

  Livraison(
      {this.client,
     this.lieuDepart,
      this.lieuArrivee,
      this.categorie,
      this.audio,
      this.telephone,
      this.dateLivraison,
      this.status
      });

  factory Livraison.fromJson(Map<String, dynamic> Parsedjson) => Livraison(
        client: Parsedjson["client"],
        lieuDepart: Parsedjson["lieuDepart"],
        lieuArrivee: Parsedjson["lieuArrivee"],
        categorie: Parsedjson["categorie"],
        audio: Parsedjson["audio"],
        telephone: Parsedjson["telephone"],
        dateLivraison: Parsedjson["dateLivraison"],
        status: Parsedjson["status"],
      );

  Map<String, dynamic> toJson() => {
        "client": client,
        "lieuDepart": lieuDepart,
        "lieuArrivee": lieuArrivee,
        "categorie": categorie,
       "status": status,
        "audio": audio,
        "telephone": telephone,
        "dateLivraison": dateLivraison,
      };

  set setCategorie(categorieId, ) {
    categorie = categorieId;
   
  }
  

  
}
