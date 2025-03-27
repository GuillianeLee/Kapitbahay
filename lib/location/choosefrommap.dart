import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart'; // Current Location

class LocationPickerScreen extends StatefulWidget {
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  GoogleMapController? _mapController;
  LatLng _currentLocation = LatLng(14.5995, 120.9842); // Default: Manila
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    _checkLocationService();
    _getCurrentLocation();
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print("Location permissions are permanently denied.");
        return;
      }
    }
  }

  Future<void> _checkLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      await Geolocator.openLocationSettings();
    }
  }

  void _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    LatLng newLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentLocation = newLocation;
      _selectedLocation = newLocation;
    });

    Future.delayed(Duration(milliseconds: 500), () {
      _mapController?.animateCamera(CameraUpdate.newLatLng(newLocation));
    });
  }

  void _confirmLocation() {
    if (_selectedLocation != null) {
      Navigator.pop(context, _selectedLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Location"), backgroundColor: Colors.teal),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(target: _currentLocation, zoom: 15),
            onMapCreated: (controller) {
              _mapController = controller;
              Future.delayed(Duration(milliseconds: 500), _getCurrentLocation);
            },
            markers: {
              if (_selectedLocation != null)
                Marker(
                  markerId: MarkerId("selectedLocation"),
                  position: _selectedLocation!,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    setState(() {
                      _selectedLocation = newPosition;
                    });
                  },
                ),
            },
            onTap: (LatLng position) {
              setState(() {
                _selectedLocation = position;
              });
            },
          ),

          // Confirm Button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text("Confirm Location", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
