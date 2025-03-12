import 'package:flutter/material.dart';
import '/dashboard/messages.dart';
import '/dashboard/activity.dart';
import '/dashboard/profile.dart';
import '/task/task.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MessagesScreen(),
    ActivityScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Messages',
    'Activity',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          _titles[_currentIndex],  // Dynamic Title
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 32.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 30.0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 26.0),
            label: '',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF45B28F),
        unselectedItemColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _categories = [
    {'title': 'Running Errands', 'icon': Icons.directions_run},
    {'title': 'Home Service', 'icon': Icons.home_repair_service},
    {'title': 'Relocation Assistance', 'icon': Icons.local_shipping},
    {'title': 'Study or Work Support', 'icon': Icons.book},
    {'title': 'Seniors or PWD Assistance', 'icon': Icons.accessibility},
    {'title': 'Event Assistance', 'icon': Icons.event},
    {'title': 'Personalized Shopping', 'icon': Icons.shopping_bag},
    {'title': 'Custom Task Requests', 'icon': Icons.assignment},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskSelectionScreen(
                    categoryTitle: _categories[index]['title'],
                  ),
                ),
              );
            },
            child: Card(
              color: Color.fromRGBO(69, 178, 143, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_categories[index]['icon'], size: 40, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    _categories[index]['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}