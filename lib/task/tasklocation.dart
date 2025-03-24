import 'package:flutter/material.dart';
import '/location/locationsearch.dart';

class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStep("Task", false),
                _buildStep("Description", false),
                _buildStep("Details", false),
                _buildStep("Location", true),
              ],
            ),
            const SizedBox(height: 20),

            // Location Input Field
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: "Location",
                prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    print("Searching for location...");
                  },
                ),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add Drop Off Text
            const Text("Add Drop off?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),

            // Use My Current Location
            GestureDetector(
              onTap: () {
                print("Using current location...");
              },
              child: Row(
                children: [
                  Icon(Icons.person_pin_circle, color: Color(0xFF45B28F)),
                  const SizedBox(width: 10),
                  const Text("Use my current location", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const Spacer(),

            // Choose from Map
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserInfoCard()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Choose from map",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Progress Indicator
  Widget _buildStep(String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: isActive ? Color.fromRGBO(69, 178, 143, 1) : Colors.grey.shade300,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: isActive ? Colors.black : Colors.grey),
        ),
      ],
    );
  }
}
