import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Profileedit extends StatefulWidget {
  @override
  _ProfileeditState createState() => _ProfileeditState();
}

class _ProfileeditState extends State<Profileedit> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String mobileNumber = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  // Load user data from Firestore
  _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        name = userData['name'] ?? '';  // Get name from Firestore
        mobileNumber = userData['mobileNumber'] ?? '';  // Get mobile number
        email = userData['email'] ?? '';  // Get email
      });
    }
  }

  // Update user data in Firestore
  _updateUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': name,
        'mobileNumber': mobileNumber,
        'email': email,
      });

      // Show a toast message when the profile is updated
      Fluttertoast.showToast(
        msg: 'Profile updated successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Go back to the profile screen after update
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(  // Add SingleChildScrollView here
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Profile Section
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpg'),  // Update to dynamic image if needed
              ),
            ),
            SizedBox(height: 16),
            // Name
            Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextFormField(
              initialValue: name,  // Set the current name from Firestore as the initial value
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                labelText: name.isEmpty ? 'Enter your name' : name,  // Display the current name as the label or placeholder
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            // Mobile Number
            Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextFormField(
              initialValue: mobileNumber,  // Set the current mobile number from Firestore
              onChanged: (value) {
                setState(() {
                  mobileNumber = value;
                });
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: mobileNumber.isEmpty ? 'Enter your mobile number' : mobileNumber,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 16),
            // Email
            Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            TextFormField(
              initialValue: email,  // Set the current email from Firestore
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: email.isEmpty ? 'Enter your email' : email,
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF45B28F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _updateUserData,  // Save changes to Firestore
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
