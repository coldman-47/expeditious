class Livraison {
  String? client;
  String? lieuDepart;
  String? lieuArrivee;
  String? categorie;

  Livraison({
    this.client,
    this.lieuDepart,
    this.lieuArrivee,
    this.categorie,
  });

  factory Livraison.fromJson(Map<String, dynamic> json) => Livraison(
      client: json["client"],
      lieuDepart: json["lieuDepart"],
      lieuArrivee: json["lieuArrivee"],
      categorie: json["categorie"]);

  Map<String, dynamic> toJson() => {
        "client": client,
        "lieuDepart": lieuDepart,
        "lieuArrivee": lieuArrivee,
        "categorie": categorie
      };

  set setCategorie(String categorieId) {
    categorie = categorieId;
  }
}
