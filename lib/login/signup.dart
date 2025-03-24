import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/login/loginuser.dart';
import '/dashboard/home.dart';
import '/firebase/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupWidget extends StatefulWidget {
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> signup(BuildContext context) async {
    final authService = AuthService();

    // is any field is empty?
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _pwController.text.isEmpty ||
        _confirmpwController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("All fields are required."),
        ),
      );
      return;
    }

    if (_pwController.text == _confirmpwController.text) {
      try {
        await authService.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
          _nameController.text, // name here
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString().isNotEmpty ? e.toString() : "An unknown error occurred."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Passwords Don't Match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 80), // top spacing

                // Welcome Text
                Text(
                  'Hello! Register to Get Started',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Inter',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1,
                  ),
                ),
                SizedBox(height: 40),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Number
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    hintText: "+63",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Create Password
                TextFormField(
                  controller: _pwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Create new password",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Re-enter Password
                TextFormField(
                  controller: _confirmpwController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Re-enter your password",
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () => signup(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),

                // Divider with Text
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Or Login with",
                          style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 20),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset('assets/images/facebook.svg'),
                      iconSize: 40,
                      onPressed: () {
                        // Facebook login logic
                      },
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/images/google.svg',
                        width: 50,
                        height: 30,
                      ),
                      onPressed: () {
                        // Google login logic
                      },
                    ),
                  ],
                ),
                SizedBox(height: 60),

                // Register Now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginWidget()),
                        );
                      },
                      child: Text(
                        "Login Now",
                        style:
                        TextStyle(color: Color.fromRGBO(69, 178, 143, 1)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}