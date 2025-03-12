import 'package:flutter/material.dart';

class Profileedit extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Profileedit> {
  String name = 'Juan Dela Cruz';
  String mobileNumber = '09123456789';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
              SizedBox(height: 16),
              Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextFormField(
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextFormField(
                initialValue: mobileNumber,
                onChanged: (value) {
                  setState(() {
                    mobileNumber = value;
                  });
                },
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 16),
              Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),
              Center( // Center the button
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      print('Name: $name');
                      print('Mobile Number: $mobileNumber');
                      print('Email: $email');
                    },
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
      ),
    );
  }
}