import 'package:flutter/material.dart';

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
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.green,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            SizedBox(height: 10),
            Text("Let's rate Sydney O.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedStars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedStars = index + 1;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              decoration: InputDecoration(
                hintText: "Write a review",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Color(0xFF45B28F), width: 2),
                      ),
                    ),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submitRating,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF45B28F), // Button color
                      foregroundColor: Colors.white, // Text color
                      padding: const EdgeInsets.symmetric(vertical: 14), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: Text("Submit", style: TextStyle(color: Colors.white)),
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
