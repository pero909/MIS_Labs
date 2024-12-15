import 'package:flutter/material.dart';

import '../services/api_service.dart';


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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will pop the screen and go back
          },
        ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          joke['setup'],
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 8),
                        Text(
                          joke['punchline'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
