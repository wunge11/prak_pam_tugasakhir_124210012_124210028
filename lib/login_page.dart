import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:praktikum_disney/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DB_Model/login_model.dart';
import 'main.dart';
import 'menu_utama.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Box<LoginModel> _myBox;
  final _username = TextEditingController();
  final _password = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  bool _obscurePassword = true;

  void initState() {
    super.initState();
    chek_if_already_login();
    _myBox = Hive.box(boxName);
  }

  void chek_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login") ?? true);
    print(newuser);

    if (newuser == false) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return MenuUtama();
      }));
    }
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/palaced.jpg", // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
          Center( // Tempatkan kartu form login di tengah
            child: Container(
              width: 300.0,
              height: 450.0,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView( // Tambahkan SingleChildScrollView di sini
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontFamily: "Disney",
                        fontSize: 40.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Enter Your Username & Password",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 177, 169, 169),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _username,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _password,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.visibility),
                          onPressed: () {
                            // Toggle the visibility of the password
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        if (checkLoginCredentials(
                            _username.text, _password.text)) {
                          logindata.setBool("login", false);
                          logindata.setString("username", _username.text);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MenuUtama();
                            }),
                          );
                          showSuccessSnackBar(context, "Login Berhasil");
                        } else {
                          showErrorSnackBar(
                              context, "Username atau Password Salah");
                          setState(() {
                            _username.clear();
                            _password.clear();
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 20, 64, 141),
                        onPrimary: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.0,
                          vertical: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Register here",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return AddRegistrationForm();
                                    }));
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkLoginCredentials(String enteredUsername, String enteredPassword) {
    for (var i = 0; i < _myBox.length; i++) {
      LoginModel? res = _myBox.getAt(i);
      if (res!.username == enteredUsername && res.password == enteredPassword) {
        return true;
      }
    }
    return false;
  }

  void showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }

  void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
