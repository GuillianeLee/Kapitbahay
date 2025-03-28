import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/firebase/firestore.dart';
import '/location/choosefrommap.dart';
import 'package:geocoding/geocoding.dart';
import '/location/locationsearch.dart';

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
        _locationChosen = true; // Continue button
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

  Future<void> _fetchCurrentLocation() async {
    try {
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Fetching location..."),
            ],
          ),
        ),
      );

      Position position = await Geolocator.getCurrentPosition();
      LatLng userLocation = LatLng(position.latitude, position.longitude);
      String address = await _getAddressFromLatLng(position.latitude, position.longitude);

      // Close loading popup
      if (mounted) {
        Navigator.pop(context);
      }

      setState(() {
        _selectedLocation = userLocation;
        _locationController.text = address;
        _locationChosen = true;
      });
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }

      print("Error fetching location: $e");

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Location Error"),
          content: const Text("Failed to get current location. Make sure location services are enabled."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
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

      // Navigate to UserInfoCard
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              UserInfoCard(
                selectedLocation: _selectedLocation!,
                selectedAddress: address,
                taskId: widget.taskId, // taskId
              ),
        ),
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

            // Use My Current Location (Updated as a Button)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _fetchCurrentLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF45B28F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.my_location, color: Colors.white),
                label: const Text(
                  "Use My Current Location",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            const Spacer(),

            // Choose from Map / Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _locationChosen ? _saveLocationDetails : _openMapScreen,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(69, 178, 143, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  _locationChosen ? "Continue" : "Choose from Map",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
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
          backgroundColor: isActive ? const Color.fromRGBO(69, 178, 143, 1) : Colors.grey.shade300,
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
