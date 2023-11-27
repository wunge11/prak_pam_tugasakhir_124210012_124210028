import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:praktikum_disney/API_Model/api_disney_model.dart';
import 'package:praktikum_disney/disney_detail.dart';

class DisneyList extends StatefulWidget {
  @override
  _DisneyListState createState() => _DisneyListState();
}

class _DisneyListState extends State<DisneyList> {
  late Future<List<Data>> characters;
  late TextEditingController _searchController;

  late List<Data> charactersList;
  late List<Data> searchResult;

  @override
  void initState() {
    super.initState();
    characters = fetchCharacters();
    _searchController = TextEditingController();
    charactersList = [];
    searchResult = [];
  }

  Future<List<Data>> fetchCharacters() async {
    final response =
    await http.get(Uri.parse('https://api.disneyapi.dev/character'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      charactersList = data.map((json) => Data.fromJson(json)).toList();
      return charactersList;
    } else {
      throw Exception('Failed to load characters');
    }
  }

  void filterCharacters(String query) {
    List<Data> result = charactersList
        .where((character) =>
    character.name!.toLowerCase().contains(query.toLowerCase()) ||
        (character.films != null &&
            character.films!.any((film) =>
                film.toLowerCase().contains(query.toLowerCase()))))
        .toList();

    setState(() {
      searchResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disney Characters',
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: "Disney",
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                filterCharacters(value);
              },
              decoration: InputDecoration(
                hintText: 'Search characters...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Data>>(
              future: characters,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data> displayCharacters =
                  searchResult.isNotEmpty ? searchResult : snapshot.data!;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: displayCharacters.length,
                    itemBuilder: (context, index) {
                      Data character = displayCharacters[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisneyDetailPage(character: character),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5.0,
                          margin: EdgeInsets.all(8.0),
                          color: Colors.blueGrey[100], // Adjust card color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: character.imageUrl != null
                                    ? ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                  child: Image.network(
                                    character.imageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Container(),
                              ),
                              SizedBox(height: 8.0),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  character.name ?? 'Unknown',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black, // Adjust text color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CharacterSearchDelegate extends SearchDelegate<Data> {
  final List<Data> charactersList;

  CharacterSearchDelegate(this.charactersList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Data> result = charactersList
        .where((character) =>
    character.name!.toLowerCase().contains(query.toLowerCase()) ||
        (character.films != null &&
            character.films!.any((film) =>
                film.toLowerCase().contains(query.toLowerCase()))))
        .toList();

    return _buildSearchResults(result);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Data> result = charactersList
        .where((character) =>
    character.name!.toLowerCase().contains(query.toLowerCase()) ||
        (character.films != null &&
            character.films!.any((film) =>
                film.toLowerCase().contains(query.toLowerCase()))))
        .toList();

    return _buildSearchResults(result);
  }

  Widget _buildSearchResults(List<Data> results) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: results.length,
      itemBuilder: (context, index) {
        Data character = results[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisneyDetailPage(character: character),
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            margin: EdgeInsets.all(8.0),
            color: Colors.blueGrey[100], // Adjust card color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: character.imageUrl != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      character.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    character.name ?? 'Unknown',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Adjust text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}