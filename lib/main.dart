import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lab',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> clothingItems = [
    {
      'name': 'T-Shirt',
      'price': '20 USD',
      'description': 'A comfortable cotton T-shirt.',
      'image': 'assets/tshirt.jpg'
    },
    {
      'name': 'Jeans',
      'price': '50 USD',
      'description': 'Stylish and durable denim jeans.',
      'image': 'assets/jeans.jpg'
    },
    {
      'name': 'Jacket',
      'price': '100 USD',
      'description': 'A warm and trendy jacket.',
      'image': './assets/jacket.jpg'
    },
    {
      'name': 'Adidas Shoes',
      'price': '150 USD',
      'description': 'Stylish Adidas Shoes',
      'image': 'assets/adidas1.jpg'
    },
    {
      'name': 'Denim Jacket',
      'price': '300 USD',
      'description': 'Stylish Denim Jacket from Columbia',
      'image': 'assets/jacket2.jpg'
    },
    {
      'name': 'Nike Shoes White',
      'price': '250 USD',
      'description': 'Nike shoes',
      'image': 'assets/nike1.jpg'
    },
    {
      'name': 'Nike Shoes Outdoor ',
      'price': '100 USD',
      'description': 'Nike Shoes made for the outdoors.',
      'image': 'assets/nike2.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('191553'), // Replace with your index number
      ),
      body: ListView.builder(
        itemCount: clothingItems.length,
        itemBuilder: (context, index) {
          final item = clothingItems[index];
          return Card(
            child: ListTile(

              leading: Image.asset(item['image']!, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item['name']!),
              subtitle: Text(item['price']!),
              onTap: () {
                // Navigate to the details screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  final Map<String, String> item;

  DetailsScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']!), // Display item name as title
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Image.asset(
              item['image']!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 10),
            Text('Price: ${item['price']}'),
            SizedBox(height: 20),
            Text(
              '${item['description']}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}