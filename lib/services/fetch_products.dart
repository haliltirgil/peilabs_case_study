import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peilabs_project/model/product.dart';

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
