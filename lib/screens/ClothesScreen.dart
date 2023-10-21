import 'package:flutter/material.dart';

class ClothesScreen extends StatefulWidget {
  const ClothesScreen({Key? key}) : super(key: key);

  @override
  _ClothesScreenState createState() => _ClothesScreenState();
}

class _ClothesScreenState extends State<ClothesScreen> {
  List<Map<String, dynamic>> clothesProducts = [
    {
      "id": "1",
      "name": "Full Sleeves Cotton Shirt",
      "description":
          "A stylish shirt for any occasion.\nMaterial : 100% Cotton\nManufacturer : Peter England\nWashing Instructions : Machine Wash only\nPrice : Rs. 750",
      "image":
          "https://www.shutterstock.com/image-photo/children-plaid-shirt-isolated-on-260nw-135995417.jpg",
    },
    {
      "id": "2",
      "name": "A Casual T-Shirt",
      "description":
          "A comfy t-shirt for everyday wear\nManufacturer : Bewakoof\nIdeal for : Daily usage\nWashing Instructions : No Machine Wash\nType : Round neck without Collar\nPrice : Rs.650/-",
      "image":
          "https://img.freepik.com/free-psd/isolated-white-t-shirt-front-view_125540-1194.jpg?size=626&ext=jpg&ga=GA1.1.3830957.1697900569&semt=ais",
    },
    {
      "id": "3",
      "name": "Jeans",
      "description":
          "A pair of jeans to complete your outfit\nFit : Regular Fit\nManufacturer : Ben Martin\nFabric : Stretchable\nAvailability : All Sizes\nWashing Instructions : Hand & Machine wash safe\nSizes : L,XL,XXl\nPrice : Rs.999/-",
      "image":
          "https://www.shutterstock.com/image-photo/jeans-on-background-blue-lie-260nw-1189112893.jpg",
    },
    {
      "id": "4",
      "name": "Kurta",
      "description":
          "An Indian Traditional outfit\nName : Kurta design short shirt with folding sleeves\nFabric : Cotton\nSleeve Length : Long Sleeves\nPattern : Solid\nSizes : M, L, XXL\nSold by : Hashtag Retail\nPrice : Rs.750/-",
      "image":
          "https://images.meesho.com/images/products/71866752/gohau_512.webp",
    },
  ];
  int? expandedProductIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clothes'),
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: ListView.builder(
        itemCount: clothesProducts.length,
        itemBuilder: (context, index) {
          final product = clothesProducts[index];
          final isExpanded = index == expandedProductIndex;

          return Card(
            elevation: 4,
            margin: EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            ]),
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
