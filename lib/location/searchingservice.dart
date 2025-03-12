import 'package:flutter/material.dart';
import 'accepted.dart';

class UserRatingPopup extends StatefulWidget {
  @override
  _UserRatingPopupState createState() => _UserRatingPopupState();
}

class _UserRatingPopupState extends State<UserRatingPopup> {
  int _selectedStars = 0;
  final TextEditingController _reviewController = TextEditingController();

  void _submitRating() {
    // Rating submission
    print("Rated: $_selectedStars stars");
    print("Review: ${_reviewController.text}");
  }

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
                          TextButton( //have to change this pa kasi it has spaces
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
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                  style: OutlinedButton.styleFrom(
                    // backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                ),
                SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UserInfoAccepted(), // const is good here
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(69, 178, 143, 1),
                      minimumSize: Size(double.infinity, 50),
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

// Usage:
// showDialog(
//   context: context,
//   builder: (context) => UserRatingPopup(),
// );
