import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:praktikum_disney/artikel_list.dart';
import 'package:praktikum_disney/disney_list.dart';
import 'package:praktikum_disney/login_page.dart';
import 'package:praktikum_disney/produk_list.dart';
import 'package:praktikum_disney/profile.dart';
import 'package:praktikum_disney/supportus.dart';
import 'package:praktikum_disney/wishlist_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MenuUtama(),
    );
  }
}

class MenuUtama extends StatefulWidget {
  const MenuUtama({Key? key}) : super(key: key);

  @override
  State<MenuUtama> createState() => _MenuUtamaState();
}

class _MenuUtamaState extends State<MenuUtama> {
  late SharedPreferences logindata;
  late String username;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    bool isDayTime = currentTime.hour >= 6 && currentTime.hour < 18;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 20, 64, 141),
                  Color.fromARGB(255, 0, 128, 255),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                'Welcome $username',
                style: TextStyle(
                  fontFamily: "Disney",
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  isDayTime ? 'weather.png' : 'night.png',
                  width: 30,
                  height: 30,
                ),
              ),
              buildClock(currentTime),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                child: Divider(
                  color: const Color.fromARGB(255, 20, 64, 141),
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'DISCOVER',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 20, 64, 141),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 100,
                child: Divider(
                  color: const Color.fromARGB(255, 20, 64, 141),
                  thickness: 2,
                ),
              ),
            ],
          ),
          CarouselSlider(
            items: [
              buildCarouselCard(
                image: 'palaced.jpg',
                title: 'Shop Disney',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
              buildCarouselCard(
                image: 'disney_event.jpg',
                title: 'Article Disney',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArtikelList()),
                  );
                },
              ),
              buildCarouselCard(
                image: 'chara_disney.jpg',
                title: 'Character Disney',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DisneyList()));
                },
              ),
            ],
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  child: Divider(
                    color: const Color.fromARGB(255, 20, 64, 141),
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'MENU',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 20, 64, 141),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 120,
                  child: Divider(
                    color: const Color.fromARGB(255, 20, 64, 141),
                    thickness: 2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('disney_market.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MenuItem(
              title: 'Shop Disney',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdukPage()),
                );
              },
              backgroundImage: '',
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('disney_event.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MenuItem(
              title: 'Disney Article',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArtikelList()),
                );
              },
              backgroundImage: '',
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('chara_disney.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MenuItem(
              title: 'Disney Character',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisneyList()),
                );
              },
              backgroundImage: '',
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('wish.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: MenuItem(
              title: 'Wishlist',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wishlist()),
                );
              },
              backgroundImage: '',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Made with ❤️ 2023',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.coffee_rounded,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.coffee_rounded,
              color: Colors.grey,
            ),
            label: 'Trakteer Us',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Colors.blueAccent,
            ),
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout_outlined,
              color: Colors.grey,
            ),
            label: "Logout",
          ),
        ],
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 249, 248, 248).withOpacity(0.7),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          if (index == 3) {
            _showLogoutConfirmationDialog();
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }

          switch (index) {
            case 0:
              showDialog(
                context: context,
                builder: (BuildContext context) => SupportUsPage(),
              );
              break;
            case 1:
            // Halaman Home, tidak perlu navigasi
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
              break;
            case 3:
              _showLogoutConfirmationDialog();
              break;
          }
        },
      ),
    );
  }

  Widget buildClock(DateTime time) {
    String formattedTime = DateFormat.Hm().format(time);
    List<String> timeParts = formattedTime.split(':');

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        children: [
          TextSpan(text: timeParts[0]),
          TextSpan(
            text: ':',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(text: timeParts[1]),
        ],
      ),
    );
  }

  void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showLogoutConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: SingleChildScrollView(
            child: Text('Are you sure you want to logout?'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                logindata.setBool("login", true);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget buildCarouselCard({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.blueAccent,
            width: 2,
          ),
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              fontFamily: "Disney",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.backgroundImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: "Disney",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
