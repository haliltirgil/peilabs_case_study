import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peilabs_project/services/fetch_products.dart';

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
}
