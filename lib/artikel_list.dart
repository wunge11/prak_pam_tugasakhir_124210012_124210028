import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:praktikum_disney/Dummy/artikel.dart';

class ArtikelList extends StatefulWidget {
  @override
  _ArtikelListState createState() => _ArtikelListState();
}

class _ArtikelListState extends State<ArtikelList> {
  late TextEditingController _searchController;
  late List<Artikel> artikelListOriginal;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    artikelListOriginal = List.from(listArtikel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Disney Articles',
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: "Disney",
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  listArtikel = artikelListOriginal.where((artikel) {
                    return artikel.name.toLowerCase().contains(value.toLowerCase());
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: 'Search Articles...',
                hintStyle: TextStyle(color: Colors.black87),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listArtikel.length,
        itemBuilder: (context, index) {
          final Artikel artikel = listArtikel[index];
          return InkWell(
            onTap: () async {
              // Navigasi ke URL saat card di-tap
              if (await canLaunch(artikel.url)) {
                await launch(artikel.url);
              } else {
                // Handle jika tidak dapat membuka URL
                print('Could not launch ${artikel.url}');
              }
            },
            child: Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                            artikel.imgUrls!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              artikel.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              artikel.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
