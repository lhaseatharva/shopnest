import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopnest/models/models.dart';

Future<List<Product>> fetchProducts(String category) async {
  final response =
      await http.get(Uri.parse('https://fakeapi.platzi.com/en/rest/products'));
  if (response.statusCode == 200) {
    final List<dynamic> productData = json.decode(response.body);

    List<Product> products =
        productData.map((json) => Product.fromJson(json)).toList();

    return products;
  } else {
    throw Exception('Failed to load products');
  }
}
