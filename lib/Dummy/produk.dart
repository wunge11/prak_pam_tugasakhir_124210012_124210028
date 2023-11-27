class Produk {
  String id;
  String name;
  String imageUrl;
  String url;
  bool isFavorite;

  Produk({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.url,
    required this.isFavorite,
  });
}

var produkList = [
  Produk(
    id: "site-Stitch",
    name: "Stitch Plush",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1231047443605?fmt=webp&qlt=70&wid=1280&hei=1280", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://www.shopdisney.com/stitch-plush-lilo-stitch-medium-15-34-412312274183.html?searchType=redirect",
    isFavorite: false,
  ),
  Produk(
    id: "site-Groot",
    name: "Groot Plush",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1230055504681?fmt=webp&qlt=70&wid=1280&hei=1280", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://www.shopdisney.com/baby-groot-big-feet-plush-guardians-of-the-galaxy-10-12-412303973699.html?searchType=redirect",
    isFavorite: false,
  ),
  Produk(
    id: "site-Wall-E",
    name: "Wall-E Plush",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1517055503878?fmt=webp&qlt=70&wid=1280&hei=1280", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://www.shopdisney.com/walle-plush-small-8-415171151084.html?isProductSearch=1&searchType=regular",
    isFavorite: false,
  ),
  Produk(
    id: "LEGO Up House",
    name: "Disney UP LEGO Set",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1716047093104-2?fmt=webp&qlt=70&wid=1280&hei=1280", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://www.shopdisney.com/lego-up-house-43217-disney100-673419378475.html?isProductSearch=1&searchType=autosuggest-popular&siteSearchTopProduct=1",
    isFavorite: false,
  ),
  Produk(
    id: "SpiderMan",
    name: "SpiderMan Action Figure",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/3710059310039?fmt=webp&qlt=70&wid=1280&hei=1280", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://www.shopdisney.com/spider-man-light-up-living-magic-sketchbook-ornament-437101498342.html?isProductSearch=1&searchType=autosuggest-popular&siteSearchTopProduct=1",
    isFavorite: false,
  ),
  Produk(
    id: "LEGO Castle Set",
    name: "Disney Castle LEGO Set",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1716047090034-2?fmt=webp&qlt=70&wid=608&hei=608", // Ganti URL gambar sesuai kebutuhan
    url:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1716047090034-2?fmt=webp&qlt=70&wid=1280&hei=1280",
    isFavorite: false,
  ),
  Produk(
    id: "Wish Set",
    name: "Wish Deluxe Figure Set",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1713047400024-2?fmt=webp&qlt=70&wid=1280&hei=1280",
    url: "https://www.shopdisney.com/wish-deluxe-figure-set-417131198450.html",
    isFavorite: false,
  ),
  Produk(
    id: "Olaf-Frozen",
    name: "Olaf Weighted Plush",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1516041283867-1?fmt=webp&qlt=70&wid=608&hei=608",
    url:
    "https://www.shopdisney.com/olaf-weighted-plush-frozen-15-415161150097.html?searchType=autosuggest",
    isFavorite: false,
  ),
  Produk(
    id: "Maleficent-Sleeping Beauty",
    name: "Maleficent Figure",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/7002101040136-1?fmt=webp&qlt=70&wid=608&hei=608",
    url:
    "https://www.shopdisney.com/maleficent-facets-light-up-figure-sleeping-beauty-disney100-028399366637.html?isProductSearch=1&searchType=autosuggest-popular&siteSearchTopProduct=1",
    isFavorite: false,
  ),
  Produk(
    id: "Turning Red",
    name: "Mei Panda Plush",
    imageUrl:
    "https://cdn-ssl.s7.disneystore.com/is/image/DisneyShopping/1232047443546?fmt=webp&qlt=70&wid=608&hei=608",
    url:
    "https://www.shopdisney.com/mei-panda-plush-turning-red-18-412326331940.html?searchType=redirect",
    isFavorite: false,
  ),
];