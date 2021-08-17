import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:peilabs_project/screen/second_screen.dart';
import 'package:peilabs_project/services/fetch_products.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Text("Ürün Listeleme"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSizedBox(context),
            _buildRow(context, 1),
            _buildColumn(context, 4),
            _buildColumn(context, 8),
            _buildColumn(context, 11),
            _buildColumn(context, 12),
          ],
        ),
      ),
    );
  }

  _buildRow(BuildContext context, int index) {
    return FutureBuilder(
      future: fetchProducts(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
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
                      if (snapshot.data[index].id == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(param: 2)),
                        );
                      }
                      if (snapshot.data[index].id == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(param: 4)),
                        );
                      }
                      if (snapshot.data[index].id == 8) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(param: 8)),
                        );
                      }
                      if (snapshot.data[index].id == 11) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(param: 11)),
                        );
                      }
                      if (snapshot.data[index].id == 12) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(param: 12)),
                        );
                      }
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

  _buildColumn(BuildContext context, int index) {
    return FutureBuilder(
      future: fetchProducts(index),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Column(
            children: [
              _buildSizedBox(context),
              _buildText(index),
              ListView.builder(
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
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            contentPadding: EdgeInsets.all(0.0),
                            insetPadding: EdgeInsets.all(0.0),
                            content:
                                Image.network(snapshot.data[index].picture),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height / 5,
                            child: Image.network(snapshot.data[index].picture),
                          ),
                          Text(snapshot.data[index].name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  _buildSizedBox(BuildContext context) {
    return SizedBox(height: MediaQuery.of(context).size.height / 50);
  }

  _buildText(int index) {
    switch (index) {
      case 2:
        return _createText("Mutfak Aletleri");
        break;
      case 4:
        return _createText("Beyaz Eşya");
        break;
      case 8:
        return _createText("Mobilya");
        break;
      case 11:
        return _createText("Ev / Dekorasyon");
        break;
      case 12:
        return _createText("Bahçe Aletleri");
        break;
      default:
        return _createText(" Tüm Eşyalar ");
    }
  }

  _createText(String name) {
    return Text(name,
        style: TextStyle(
          fontSize: 21,
          color: Colors.white,
        ));
  }
}
