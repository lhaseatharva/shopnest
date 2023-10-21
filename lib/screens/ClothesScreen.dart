import 'package:flutter/material.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({super.key});

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  // Sample data for products in the "Clothes" category, including image URLs
  final List<Map<String, dynamic>> clothesProducts = [
    {
      "id": 1,
      "name": "Shirt 1",
      "description": "A stylish shirt.",
      "image":
          "https://example.com/shirt1.jpg", // Replace with actual image URL
    },
    {
      "id": 2,
      "name": "T-Shirt 1",
      "description": "A comfy t-shirt.",
      "image":
          "https://example.com/tshirt1.jpg", // Replace with actual image URL
    },
    {
      "id": 3,
      "name": "Jeans 1",
      "description": "A pair of jeans.",
      "image":
          "https://example.com/jeans1.jpg", // Replace with actual image URL
    },
  ];

  int? selectedProductIndex; // To track the selected product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemCount: clothesProducts.length,
        itemBuilder: (context, index) {
          final product = clothesProducts[index];
          final isSelected = index == selectedProductIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedProductIndex = isSelected ? null : index;
              });
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    product["image"] as String,
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Handle image load errors
                      return Icon(Icons.error);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(product["name"] as String),
                  ),
                  if (isSelected) ...[
                    // Display product details when selected
                    Text("Description: ${product["description"] as String}"),
                    // Add more details as needed
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
