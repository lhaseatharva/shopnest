import 'package:flutter/material.dart';
import 'package:shopnest/models/models.dart';
import 'package:shopnest/services/api.dart';

class ItemScreen extends StatelessWidget {
  final String category;

  ItemScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items in $category'),
      ),
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No items available in $category.'));
          } else {
            final items = snapshot.data;
            return ListView.builder(
              itemCount: items?.length,
              itemBuilder: (context, index) {
                final item = items?[index];
                return ListTile(
                  title: Text(item!.name),
                  subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
