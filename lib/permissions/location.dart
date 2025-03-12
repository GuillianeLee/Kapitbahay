import 'package:flutter/material.dart';
import '/task/task.dart';
import '/dashboard/home.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  void _navigateToNextPage(BuildContext context) {
    Navigator.pop(context); // Close Dialog
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.grey[200],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.notifications, size: 40, color: Color.fromRGBO(69, 178, 143, 1)),

          const SizedBox(height: 16),
          const Text(
            'Allow Kapitbahay to send you notifications?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(69, 178, 143, 1),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () => _navigateToNextPage(context),
            child: const Text('ALLOW', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(69, 178, 143, 1),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () => Navigator.pop(context), // Close dialog
            child: const Text('DON’T ALLOW', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Next Page')),
      body: const Center(child: Text('You have allowed location access!')),
    );
  }
}