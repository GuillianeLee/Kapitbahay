import 'package:flutter/material.dart';
import '/firebase/firestore.dart';
import '/location/choosefrommap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/location/locationsearch.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationSelectionScreen extends StatefulWidget {
  final String taskId;

  LocationSelectionScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  final TextEditingController _locationController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService();
  LatLng? _selectedLocation;
  bool _locationChosen = false;

  Future<void> _openMapScreen() async {
    final LatLng? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (result != null) {
      String address = await _getAddressFromLatLng(result.latitude, result.longitude);
      setState(() {
        _selectedLocation = result;
        _locationController.text = address;
        _locationChosen = true; // Active Continue button
      });
    }
  }

  Future<String> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
      return "Unknown Location";
    } catch (e) {
      print("Error getting address: $e");
      return "Error retrieving address";
    }
  }

  void _saveLocationDetails() async {
    if (_selectedLocation == null) return;

    try {
      String address = await _getAddressFromLatLng(
        _selectedLocation!.latitude,
        _selectedLocation!.longitude,
      );

      Map<String, dynamic> locationData = {
        'latitude': _selectedLocation!.latitude,
        'longitude': _selectedLocation!.longitude,
        'address': address,
      };

      await _databaseService.updateTask(widget.taskId, locationData);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserInfoCard()),
      );
    } catch (e) {
      print("Error updating location: $e");
    }
  }

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
              readOnly: true,
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

            // Use My Current Location
            GestureDetector(
              onTap: () async {
                Position position = await Geolocator.getCurrentPosition();
                LatLng userLocation = LatLng(position.latitude, position.longitude);
                String address = await _getAddressFromLatLng(position.latitude, position.longitude);

                setState(() {
                  _selectedLocation = userLocation;
                  _locationController.text = address;
                  _locationChosen = true;
                });
              },
              child: Row(
                children: [
                  Icon(Icons.person_pin_circle, color: Color(0xFF45B28F)),
                  const SizedBox(width: 10),
                  const Text("Use my current location", style: TextStyle(fontSize: 16)),
                ],
              ),
            ), const Spacer(),

            // Choose from Map / Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _locationChosen ? _saveLocationDetails : _openMapScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  _locationChosen ? "Continue" : "Choose from map",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Progress
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
