// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.parentId,
    this.picture,
    this.name,
  });

  int id;
  int parentId;
  String picture;
  String name;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        parentId: json["parentId"] == null ? null : json["parentId"],
        picture: json["picture"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId == null ? null : parentId,
        "picture": picture,
        "name": name,
      };
}
