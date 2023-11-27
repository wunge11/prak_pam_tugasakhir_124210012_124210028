import 'package:flutter/material.dart';
import 'package:praktikum_disney/API_Model/api_disney_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DisneyDetailPage extends StatelessWidget {
  final Data character;

  DisneyDetailPage({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          character.name ?? 'Unknown Character',
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: "Disney",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCharacterImage(character.imageUrl),
              SizedBox(height: 16.0),
              _buildCategoryTitle('Films:'),
              _buildCategoryList(character.films),
              SizedBox(height: 16.0),
              _buildCategoryTitle('TV Shows:'),
              _buildCategoryList(character.tvShows),
              SizedBox(height: 16),
              _buildCategoryTitle('Video Games:'),
              _buildCategoryList(character.videoGames),
              SizedBox(height: 16),
              _buildCategoryTitle('Created:'),
              _buildCategoryText(character.createdAt),
              SizedBox(height: 16),
              _buildCategoryTitle('Updated:'),
              _buildCategoryText(character.updatedAt),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildSeeMoreButton(character.sourceUrl),
    );
  }

  Widget _buildCharacterImage(String? imageUrl) {
    return Container(
      height: 200,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: imageUrl != null
            ? Image.network(
          imageUrl,
          fit: BoxFit.cover,
        )
            : Placeholder(), // Placeholder jika imageUrl null
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        //fontFamily: "Disney",
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCategoryList(List<String>? categoryList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categoryList?.map((category) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            '- $category',
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList() ?? [],
    );
  }

  Widget _buildCategoryText(String? text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text ?? '-',
        style: TextStyle(fontSize: 16,
        fontFamily: "Waltograph"),
      ),
    );
  }
}

Widget _buildSeeMoreButton(String? url) {
  return FloatingActionButton.extended(
    onPressed: () {
      _launchURL(url ?? '');
    },
    icon: Icon(Icons.animation_outlined),
    label: Text(
      "More",
      style: TextStyle(
        fontSize: 13.0,
      ),
    ),
  );
}
void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}