import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peilabs_project/model/product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      appBar: AppBar(
        title: Text("Ürün Listeleme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSizedBox(context),
            _buildRows(context, 1),
            _buildSizedBox(context),
            _buildColumns(context, 5),
          ],
        ),
      ),
    );
  }

  _showData() {
    return FutureBuilder(
      future: fetchProducts(1),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading...."),
            ),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                shadowColor: Colors.red,
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 5,
                      child: Image.network(snapshot.data[index].picture),
                    ),
                    Text(snapshot.data[index].name),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  _buildRows(BuildContext context, int index) {
    return FutureBuilder(
      future: fetchProducts(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading...."),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data[index].name);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(snapshot.data[index].picture),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  _buildColumns(BuildContext context, int index) {
    return FutureBuilder(
      future: fetchProducts(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: Text("Loading...."),
            ),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    print(snapshot.data[index].name);
                  },
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 5,
                        child: Image.network(snapshot.data[index].picture),
                      ),
                      Text(snapshot.data[index].name),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  _buildSizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 50,
    );
  }

  Future<List<Product>> fetchProducts(int index) async {
    var url = Uri.parse(
        "https://raw.githubusercontent.com/haliltirgil/peilabs_jsonfile/main/jsonArray.json");
    var response = await http.get(url);
    var jsonData = json.decode(response.body);

    List<Product> itemsForCategory = [];
    List<Product> items = [];
    List<Product> itemsForKitchen = [];
    List<Product> itemsForMajorAppliance = [];
    List<Product> itemsForFurniture = [];
    List<Product> itemsForDecoration = [];
    List<Product> itemsForGardenTools = [];

    for (var pr in jsonData) {
      Product p = Product(
          id: pr["id"],
          parentId: pr["parentId"],
          picture: pr["picture"],
          name: pr["name"]);

      if (pr["parentId"] == null) {
        itemsForCategory.add(p);
      }
      if (pr["parentId"] == 2) {
        itemsForKitchen.add(p);
      }
      if (pr["parentId"] == 4) {
        itemsForMajorAppliance.add(p);
      }
      if (pr["parentId"] == 8) {
        itemsForFurniture.add(p);
      }
      if (pr["parentId"] == 11) {
        itemsForDecoration.add(p);
      }
      if (pr["parentId"] == 12) {
        itemsForGardenTools.add(p);
      }
      if (pr["parentId"] != null) {
        items.add(p);
      }
    }

    switch (index) {
      case 1:
        return itemsForCategory;
        break;
      case 2:
        return itemsForKitchen;
        break;
      case 3:
        return itemsForMajorAppliance;
        break;
      case 4:
        return itemsForFurniture;
        break;
      case 5:
        return itemsForDecoration;
        break;
      case 6:
        return itemsForGardenTools;
        break;

      default:
        return items;
    }
  }
}
