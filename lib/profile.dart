import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isHovered = false;
  final ImagePicker _picker = ImagePicker();
  late SharedPreferences _prefs;

  List<String> _imagePaths = [
    "assets/piodanwunge.jpeg",
    "assets/piodanwunge.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    loadImagesFromPrefs();
  }

  Future<void> loadImagesFromPrefs() async {
    setState(() {
      _imagePaths[0] = _prefs.getString('imagePath0') ?? _imagePaths[0];
      _imagePaths[1] = _prefs.getString('imagePath1') ?? _imagePaths[1];
    });
  }

  Future<void> saveImageToPrefs(int index, String path) async {
    await _prefs.setString('imagePath$index', path);
  }

  Future<void> _getImage(bool isCamera, int index) async {
    final XFile? image;
    if (isCamera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      if (image != null) {
        _imagePaths[index] = image.path;
        saveImageToPrefs(index, image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profil Kami",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildProfileCard(
              'Relvio Kyrie Matchura',
              '124210012',
              'Prak Pemrograman Aplikasi Mobile SI-A',
              'Pencinta Kucing lucu dan fans Wilson',
              _imagePaths[0],
              index: 0,
            ),
            buildProfileCard(
              'Prita Isworo Wunge',
              '124210028',
              'Prak Pemrograman Aplikasi Mobile SI-A',
              'Suka membaca fiksi serta menonton video kucing lucu dan gameplay horror',
              _imagePaths[1],
              index: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(
      String nama,
      String nim,
      String kelas,
      String hobi,
      String imagePath,
      {required int index}
      ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          transform: isHovered
              ? Matrix4.diagonal3Values(1.05, 1.05, 1)
              : Matrix4.identity(),
          alignment: Alignment.center,
          child: Card(
            elevation: 4.0,
            child: Container(
              width: 400.0,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: FileImage(File(imagePath)),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    nama,
                    style:
                    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    nim,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    kelas,
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
                  ),
                  SizedBox(height: 4.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      hobi,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _getImage(false, index),
                        child: Text('Pilih dari Galeri'),
                      ),
                      SizedBox(width: 10.0),
                      ElevatedButton(
                        onPressed: () => _getImage(true, index),
                        child: Text('Ambil Foto'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
