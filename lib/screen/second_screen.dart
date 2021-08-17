import 'package:flutter/material.dart';
import 'package:peilabs_project/services/fetch_products.dart';

class SecondPage extends StatelessWidget {
  SecondPage({Key key, this.param}) : super(key: key);

  final int param;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      appBar: AppBar(
        title: Text("Ürünler"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildColumn(context, param),
          ],
        ),
      ),
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
              SizedBox(height: MediaQuery.of(context).size.height / 50),
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
                  );
                },
              ),
            ],
          );
        }
      },
    );
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
    return Text(
      name,
      style: TextStyle(
        fontSize: 21,
        color: Colors.white,
      ),
    );
  }
}
