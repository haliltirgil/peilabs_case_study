import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listeleme"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildRows(context),
            buildColumns(context),
          ],
        ),
      ),
    );
  }

  buildRows(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 100,
            color: Colors.pink,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 100,
            color: Colors.white,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 100,
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  buildColumns(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 200,
            color: Colors.red,
          ),
          Container(
            height: 200,
            color: Colors.blue,
          ),
          Container(
            height: 200,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
