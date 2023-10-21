import 'package:flutter/material.dart';

class ElectronicsScreen extends StatefulWidget {
  const ElectronicsScreen({Key? key}) : super(key: key);

  @override
  _ElectronicsScreenState createState() => _ElectronicsScreenState();
}

class _ElectronicsScreenState extends State<ElectronicsScreen> {
  List<Map<String, dynamic>> electronicsProducts = [
    {
      "id": "1",
      "name": "HP 14s Laptop",
      "description":
          "A high-performance laptop for all your needs\nRAM : 8 GB\nStorage : 256 GB SSD\nProcessor : AMD Ryzen 3000 Series\nManufacturer : HP\nDisplay : 14 inches Full HD Non-touch Display\nPrice : Rs. 37500/-",
      "image":
          "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1615414864-hp-stream-1615414857.jpg?crop=0.875xw:0.875xh;0.0619xw,0.0326xh&resize=980:*",
    },
    {
      "id": "2",
      "name": "Air Conditioner",
      "description":
          "A powerful air conditioner to keep you cool.\nManufacturer : Blue Star\nCapacity : 1.5 Ton\nType : Split AC\n5 Star Energy Rating\nPrice : Rs.30000",
      "image":
          "https://www.shutterstock.com/image-vector/white-air-condition-isolated-on-260nw-758762737.jpg",
    },
    {
      "id": "3",
      "name": "Smart TV",
      "description":
          "An Android based smart TV for your entertainment.\nManufacturer : LG\nScreen Size : 32 inches\nConnectivity : 2 HDMI ports & 1 USB port to connect hard drives & other USB devices\nSound : 10 Watts Output\nSound by : Dolby Atmos\nPrice : Rs. 15990/-",
      "image":
          "https://www.shutterstock.com/image-photo/4k-monitor-isolated-on-white-260nw-357968483.jpg",
    },
    {
      "id": "4",
      "name": "Microwave Oven",
      "description":
          "A convenient microwave oven for cooking\nSolo Microwave:For affordable reheating, defrosting & cooking\nCapacity : 17L\nWarranty : 1 Year from Date of Purchase\nEnergy Consumption : 1200 Watts Annually\nPrice : Rs.5000/-",
      "image":
          "https://www.shutterstock.com/image-illustration/image-microwave-oven-on-white-260nw-83809138.jpg",
    },
  ];
  int? expandedProductIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electronics'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: ListView.builder(
        itemCount: electronicsProducts.length,
        itemBuilder: (context, index) {
          final product = electronicsProducts[index];
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
