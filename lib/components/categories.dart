import 'package:flutter/material.dart';
import 'package:nrj_express/api/categorie_service.dart';
import 'package:nrj_express/models/livraison.dart';

class Categories extends StatefulWidget {
  final String title = 'Type de transport';
  final int index = 1;
  final double stepValue = 0.33;
  final Livraison delivery;
  final ValueChanged<int> progress;

  const Categories({Key? key, required this.progress, required this.delivery})
      : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late List<dynamic> categories = [];
  CategorieService categorieSrv = CategorieService();

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  _loadCategories() async {
    var _categories = await categorieSrv.getAll();
    setState(() {
      categories = _categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          ButtonBar(alignment: MainAxisAlignment.center, children: [
            for (var categorie in categories)
              Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 10),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade100)),
                      onPressed: () {
                        widget.delivery.categorie = categorie['_id'];
                        widget.progress(widget.index + 1);
                      },
                      child: Container(
                          height: 150,
                          width: 175,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/${categorie["label"]}.png'),
                                  fit: BoxFit.contain))))),
          ])
        ]));
  }
}
