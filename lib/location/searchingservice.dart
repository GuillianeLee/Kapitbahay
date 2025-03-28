import 'package:flutter/material.dart';
import 'accepted.dart';

class Kapitbuddyfinder extends StatefulWidget {
  @override
  _KapitbuddyfinderState createState() => _KapitbuddyfinderState();
}

class _KapitbuddyfinderState extends State<Kapitbuddyfinder> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  backgroundImage: NetworkImage("https://via.placeholder.com/150"),
                ),
                const SizedBox(width: 10),

                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Sydney O.",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.phone, color: Colors.green, size: 18),
                          SizedBox(width: 5),
                          Text("0912 678 8919", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(Icons.location_on, color: Colors.blue, size: 18),
                          SizedBox(width: 5),
                          Text("Azure Beach", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Row( //rating and task details
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 18),
                          Text(
                              "4.8",
                              style: TextStyle(fontSize: 16)),
                          TextButton(
                            onPressed: () {}, // Insert task details
                            child: const Text(
                              "View Task Details",
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UserInfoAccepted(),
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
                      "Accept",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Usage: Call this inside a widget
// showDialog(
//   context: context,
//   builder: (context) => Kapitbuddyfinder(),
// );
