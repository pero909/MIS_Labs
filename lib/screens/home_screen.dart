import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../widgets/joke_card.dart';
import 'joke_type_screen.dart';
import 'FavoritesScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<String>> jokeTypes;

  @override
  void initState() {
    super.initState();
    jokeTypes = ApiServices().fetchJokeTypes(); // Fetch joke types from API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joke Types (191553)'),
        actions: [
          // Heart icon for navigating to the Favorites page
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Colors.red, // Make the heart red
              size: 30,
            ),
            onPressed: () {
              // Navigate to the Favorites Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(
              Icons.casino,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/randomJoke');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: jokeTypes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No joke types found'));
          } else {
            final types = snapshot.data!;
            return ListView.builder(
              itemCount: types.length,
              itemBuilder: (context, index) {
                return JokeCard(
                  type: types[index],
                  onTap: () {
                    // Navigate to the JokeTypeScreen with the selected type
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => JokeTypeScreen(type: types[index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
