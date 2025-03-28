import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import '/location/searchingservice.dart';

class UserInfoCard extends StatefulWidget {
  final LatLng selectedLocation;
  final String selectedAddress;
  final String taskId;

  const UserInfoCard({
    Key? key,
    required this.selectedLocation,
    required this.selectedAddress,
    required this.taskId,
  }) : super(key: key);

  @override
  _UserInfoCardState createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  int budget = 0;
  int additionalCost = 0;
  double serviceFee = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTaskDetails();
  }

  void _fetchTaskDetails() async {
    try {
      setState(() => isLoading = true);

      print("🔍 Fetching Task Details for ID: ${widget.taskId}");

      DocumentSnapshot taskSnapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.taskId)
          .get();

      if (taskSnapshot.exists) {
        var data = taskSnapshot.data() as Map<String, dynamic>;
        print("Firestore Data Retrieved: $data");

        setState(() {
          budget = (data['budget'] ?? 0).toInt();
          additionalCost = (data['additionalCost'] ?? 0).toInt();
          serviceFee = (data['serviceFee'] != null)
              ? data['serviceFee'].toDouble()
              : (0.10 * (budget + additionalCost));
          isLoading = false;
        });

        print("Updated State -> Budget: $budget, Additional Cost: $additionalCost, Service Fee: $serviceFee");
      } else {
        print("❌ Task document does not exist!");
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("❌ Error fetching task details: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Google Maps
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.selectedLocation, // pin
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("selectedLocation"),
                position: widget.selectedLocation,
                infoWindow: InfoWindow(title: widget.selectedAddress),
              ),
            },
          ),

          // Bottom Payment Details
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Dynamic Location Name
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          widget.selectedAddress,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Task Cost Breakdown
                  buildPriceRow("Task", "P ${budget}"),
                  buildPriceRow("Additional Fee (travel, product, etc)",
                      "P ${additionalCost}"),
                  buildPriceRow("Service Fee (10%)", "P ${serviceFee}"),

                  const Divider(),

                  // Total Cost
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "P ${(budget + additionalCost + serviceFee).toStringAsFixed(2)}",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Done Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Kapitbuddyfinder()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(69, 178, 143, 1),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Done",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Price Rows
  Widget buildPriceRow(String label, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          Text(
            price,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
