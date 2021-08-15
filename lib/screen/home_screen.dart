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
      appBar: AppBar(
        title: Text("Ürün Listeleme"),
      ),
      body: Container(
        child: _buildRows(context),
      ),
    );
  }

  _showData() {
    return FutureBuilder(
      future: fetchProducts(),
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
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data[index].name);
                    },
                    child: Container(
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

  _buildRows(BuildContext context) {
    return FutureBuilder(
      future: fetchProducts(),
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
                  child: InkWell(
                    onTap: () {
                      print(snapshot.data[index].name);
                    },
                    child: Container(
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

  _buildColumns(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      itemBuilder: (context, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 8,
          child: Card(
            child: Center(
              child: Text('Ürünler'),
            ),
          ),
        );
      },
    );
  }

  _buildSizedBox(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 40,
    );
  }

  Future<List<Product>> fetchProducts() async {
    var url = Uri.parse(
        "https://raw.githubusercontent.com/haliltirgil/peilabs_jsonfile/main/jsonArray.json");
    var response = await http.get(url);
    var jsonData = json.decode(response.body);

    List<Product> itemsForCategory = [];

    for (var pr in jsonData) {
      Product p = Product(
          id: pr["id"],
          parentId: pr["parentId"],
          picture: pr["picture"],
          name: pr["name"]);

      if (pr["parentId"] == null) {
        itemsForCategory.add(p);
      }
    }

    return itemsForCategory;
  }
}
