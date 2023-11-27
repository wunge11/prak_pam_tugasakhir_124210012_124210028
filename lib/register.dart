import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'DB_Model/login_model.dart';
import 'main.dart';

class AddRegistrationForm extends StatefulWidget {
  const AddRegistrationForm({Key? key}) : super(key: key);

  @override
  _AddRegistrationFormState createState() => _AddRegistrationFormState();
}

class _AddRegistrationFormState extends State<AddRegistrationForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late Box<LoginModel> _myBox;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box(boxName);
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
          Center(
            child: Container(
              width: 300.0,
              height: 450.0,
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an Account",
                      style: TextStyle(
                        fontFamily: "Disney",
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _usernameController,
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
                      controller: _passwordController,
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
                        _myBox.add(LoginModel(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ));
                        Navigator.pop(context);
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
                        "Register",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
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
}
