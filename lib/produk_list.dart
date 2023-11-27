import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praktikum_disney/Dummy/produk.dart';
import 'package:praktikum_disney/wishlist_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProdukPage extends StatefulWidget {
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  late TextEditingController _searchController;
  late List<Produk> produkListOriginal;

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

  void _toggleFavorite(int index) {
    setState(() {
      produkList[index].isFavorite = !produkList[index].isFavorite;
    });
  }

  void _showSnackBar(bool isFavorite, String itemName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite
              ? '$itemName ditambahkan ke Favorit'
              : '$itemName dihapus dari Favorit',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    produkListOriginal = List.from(produkList);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Disney Shop',
            style: TextStyle(
              fontFamily: "Disney",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wishlist()),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    produkList = produkListOriginal.where((produk) {
                      return produk.name.toLowerCase().contains(value.toLowerCase());
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search Products...',
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
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: produkList.length,
                    itemBuilder: (context, index) {
                      final Produk place = produkList[index];
                      return InkWell(
                        onTap: () {
                          _launchURL(place.url);
                        },
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15.0),
                                ),
                                child: Container(
                                  height: 120.0,
                                  width: double.infinity,
                                  color: Colors.blue,
                                  child: Image.network(
                                    place.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  place.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _toggleFavorite(index);
                                  _showSnackBar(
                                      produkList[index].isFavorite, place.name);
                                },
                                icon: produkList[index].isFavorite
                                    ? const Icon(Icons.bookmark_add,
                                    color: Color.fromARGB(255, 255, 199, 59))
                                    : const Icon(Icons.bookmark_border),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _launchURL('https://www.shopdisney.com/');
                  },
                  child: Text('Jelajahi Lebih Banyak Produk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}