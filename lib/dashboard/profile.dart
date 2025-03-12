import 'package:flutter/material.dart';
import '/dashboard/profilesetting.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfileScreen()),
                          );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/profile.jpg'),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Juan Dela Cruz',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.verified, color: Colors.green, size: 20),
                        ],
                      ),
                      // Verification Badges
                      sectionTitle('Verification Badges'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          badgeImage('assets/badges/Verified.png'),
                        ],
                      ),

                      // Performance & Quality Badges
                      sectionTitle('Performance & Quality Badges'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          badgeImage('assets/badges/Founding.png'),
                        ],
                      ),

                      // Reviews
                      sectionTitle('Reviews'),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '5.00',
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 6),
                          Icon(Icons.star, color: Colors.amber, size: 24),
                        ],
                      ),
                      SizedBox(height: 12),
                      reviewCard(
                        'assets/reviewer.jpg',
                        'Guillermo Raby',
                        'Juan is very accommodating and easy to talk to. Very smooth transaction.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6),
        Divider(thickness: 1),
        SizedBox(height: 10),
      ],
    );
  }

  Widget badgeImage(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Image.asset(
        imagePath,
        width: 80,
        height: 80,
      ),
    );
  }

  Widget reviewCard(String profilePath, String name, String review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(radius: 20, backgroundImage: AssetImage(profilePath)),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Row(children: List.generate(5, (index) => Icon(Icons.star, size: 16, color: Colors.amber))),
              SizedBox(height: 4),
              Text(review, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

