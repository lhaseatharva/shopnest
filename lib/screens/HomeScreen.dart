import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopnest/screens/EelctronicsScreen.dart';
import 'package:shopnest/screens/ClothesScreen.dart';
import 'package:shopnest/screens/ShoesScreen.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopNest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> categories = [];
  List<String> categoriesToDisplay = [
    'Clothes',
    'Electronics',
    'Shoes',
  ];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final List<Map<String, dynamic>> categoryList = data
          .map((item) => {
                "id": item['id'],
                "name": item['name'] as String,
              })
          .toList();
      setState(() {
        categories = categoryList;
      });
    } else {
      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to load categories');
    }
  }

  Future<void> addCategory(String categoryName) async {
    final Map<String, String> data = {
      "name": categoryName,
      "image": "https://placeimg.com/640/480/any",
    };

    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/categories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      fetchCategories();
    } else {
      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to add category');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    final response = await http.delete(
      Uri.parse('https://api.escuelajs.co/api/v1/categories/$categoryId'),
    );

    if (response.statusCode == 200) {
      fetchCategories();
    } else {
      print('API Response Code: ${response.statusCode}');
      print('API Response Body: ${response.body}');
      throw Exception('Failed to delete category');
    }
  }

  Future<void> _showAddCategoryDialog() async {
    String categoryInput = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            onChanged: (value) {
              categoryInput = value;
            },
            decoration: InputDecoration(hintText: 'Category Name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (categoryInput.isNotEmpty) {
                  addCategory(categoryInput);
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteCategoryDialog(
      int categoryId, String categoryName) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: Text(
              'Are you sure you want to delete the category "$categoryName"?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteCategory(categoryId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('ShopNest'),
      ),
      body: categories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final categoryId = category["id"];
                final categoryName = category["name"] as String;

                return GestureDetector(
                  onLongPress: () {
                    _showDeleteCategoryDialog(categoryId, categoryName);
                  },
                  child: ListTile(
                    title: Text(categoryName),
                    onTap: () {
                      if (categoriesToDisplay.contains(categoryName)) {
                        if (categoryName == "Electronics") {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ElectronicsScreen(),
                          ));
                        } else if (categoryName == "Clothes") {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClothesScreen(),
                          ));
                        } else if (categoryName == "Shoes") {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShoesScreen(),
                          ));
                        }
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCategoryDialog();
        },
        tooltip: 'Add Category',
        child: const Icon(Icons.add),
      ),
    );
  }
}
