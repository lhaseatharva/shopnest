import 'package:flutter/material.dart';

class ShoesScreen extends StatefulWidget {
  const ShoesScreen({Key? key}) : super(key: key);

  @override
  _ShoesScreenState createState() => _ShoesScreenState();
}

class _ShoesScreenState extends State<ShoesScreen> {
  List<Map<String, dynamic>> shoesProducts = [
    {
      "id": "1",
      "name": "Running Shoes",
      "description":
          "High-performance running shoes for athletes.\nBrand: Nike\nSize: 9\nMaterial : Mesh\nClosure Type : Lace-up\nSole Material : Rubber\nPrice: Rs. 1200/-",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-i33nmvrM40p_BvG0FwEwCAxYnpQZrBBHGaVrn7dyKWxcHeQEOux9peuu755XMbcg038&usqp=CAU",
    },
    {
      "id": "2",
      "name": "Casual Sneakers",
      "description":
          "Stylish and comfortable sneakers for everyday wear\nClosure Type: Lace-up\nBrand : Sparx\nSole Material : Ethylene Vinyl Acetate\nSize : 8\nPrice : Rs. 800/-",
      "image": "https://i.ebayimg.com/images/g/iAMAAOSwlwJkx5dI/s-l400.jpg",
    },
    {
      "id": "3",
      "name": "Formal Shoes",
      "description":
          "Classic formal shoes for a polished look.\nBrand: Hush Puppies\nMaterial Type : Denim\nClosure Type : Lace-Up\nHeel Type : Platform Heel\nSize: 10\nPrice: Rs. 1500/-",
      "image":
          "https://media.istockphoto.com/id/172417586/photo/elegant-black-leather-shoes.jpg?s=612x612&w=0&k=20&c=c_tTljwbu2m0AGxwb27NxCgG0Y2Cv-C4v8q6V36RYbw=",
    },
    {
      "id": "4",
      "name": "Sandals",
      "description":
          "Casual Sandals for everyday use\nBrand: Paragon\nSize: 10\nMaterial Type : Polyurethane\nClosure Type : Hook & Loop\nStyle : Sandal\nStrap Type : Adjustable Strap\nPrice: Rs. 500/-",
      "image":
          "https://t3.ftcdn.net/jpg/02/77/20/32/360_F_277203231_43ieKXmzLPYtwqOYvBc4xU3Tdb4LjE9e.jpg",
    },
  ];
  int? expandedProductIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shoes'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: ListView.builder(
        itemCount: shoesProducts.length,
        itemBuilder: (context, index) {
          final product = shoesProducts[index];
          final isExpanded = index == expandedProductIndex;

          return Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedProductIndex = isExpanded ? null : index;
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product["image"] as String,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    product["name"] as String,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if (isExpanded) ...[
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Description: ${product["description"] as String}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                                context, 'Buy Now', product['name']);
                          },
                          child: Text("Buy Now"),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                                context, 'Add to Cart', product['name']);
                          },
                          child: Text("Add to Cart"),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String action, String productName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(action),
          content: Text('Do you want to $action for $productName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement the action here, e.g., navigate to payment page
                Navigator.of(context).pop();
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }
}
