import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praktikum_disney/Dummy/produk.dart';
import 'package:url_launcher/url_launcher.dart';
import 'produk_list.dart';

class Wishlist extends StatefulWidget {
  @override
  _WishlistState createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  late TextEditingController _searchController;
  late List<Produk> favoriteSitusListOriginal;
  late List<Produk> displayedProdukList; // Tambahkan variabel ini

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    favoriteSitusListOriginal = List.from(produkList.where((place) => place.isFavorite).toList());
    displayedProdukList = List.from(favoriteSitusListOriginal); // Inisialisasi displayedProdukList
  }

  void _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      print('Error launching URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Wishlist',
            style: TextStyle(
              fontFamily: "Disney",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
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
                    displayedProdukList = favoriteSitusListOriginal.where((produk) {
                      return produk.name.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Wishlist...',
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
        body: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: displayedProdukList.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wishlist tidak ditemukan',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProdukPage(),
                              ),
                            );
                          },
                          child: Text('Jelajahi toko'),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: displayedProdukList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 0, 0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                displayedProdukList[index].imageUrl),
                            backgroundColor: Colors.transparent,
                          ),
                          title: InkWell(
                            onTap: () {
                              _launchURL(displayedProdukList[index].url);
                            },
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 60,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayedProdukList[index].name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
