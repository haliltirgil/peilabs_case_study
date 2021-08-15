import 'dart:convert';

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
        child: _showAllData(),
      ),
    );
  }

  _showAllData() {
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
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data[index].picture),
                ),
                title: Text(snapshot.data[index].id.toString()),
              );
            },
          );
        }
      },
    );
  }

  _buildRows(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: ListView.builder(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Center(
                child: Text('Kategori Alanı'),
              ),
            );
          }),
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
    List<Product> items = [];

    for (var pr in jsonData) {
      Product p = Product(
          id: pr["id"],
          parentId: pr["parentId"],
          picture: pr["picture"],
          name: pr["name"]);

      items.add(p);
    }

    return items;
  }
}
