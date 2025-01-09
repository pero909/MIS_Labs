import 'package:flutter/material.dart';

import '../services/api_service.dart';
import 'FavoritesScreen.dart';

List<Map<String, dynamic>> favoriteJokes = [];
class JokeTypeScreen extends StatefulWidget {
  final String type;

  JokeTypeScreen({required this.type});

  @override
  _JokeTypeScreenState createState() => _JokeTypeScreenState();
}

class _JokeTypeScreenState extends State<JokeTypeScreen> {
  late Future<List<Map<String, dynamic>>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = ApiServices().fetchJokesByType(widget.type); // Fetch jokes by type
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes of type: ${widget.type}'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No jokes found'));
          } else {
            final jokesList = snapshot.data!;
            return ListView.builder(
              itemCount: jokesList.length,
              itemBuilder: (context, index) {
                final joke = jokesList[index];
                return Card(
                  color: Colors.grey[200], // Silver color for the box
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                    title: Text(joke['setup']),
                    subtitle: Text(joke['punchline']),
                    trailing: IconButton(
                    icon: Icon(
                    favoriteJokes.contains(joke)
                    ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoriteJokes.contains(joke) ? Colors.red : null,
                    ),
                    onPressed: () {
                    setState(() {
                    if (favoriteJokes.contains(joke)) {
                    favoriteJokes.remove(joke); // Remove from favorites
                    } else {
                    favoriteJokes.add(joke); // Add to favorites
                    }
                    });
                    },
                   ),
                  )
                );
              },
            );
          }
        },
      ),
    );
  }
}
