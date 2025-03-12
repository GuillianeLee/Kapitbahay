import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// to handle dynamic usernames (taken from now?)
class RatingPopup extends StatefulWidget {
  final String userName;
  final String userImage;

  const RatingPopup({
    Key? key,
    required this.userName,
    required this.userImage,
  }) : super(key: key);

  @override
  _RatingPopupState createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  double rating = 0;
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            const SizedBox(height: 10),

            Text(
              "Let’s rate ${widget.userName}’s service",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            RatingBar.builder(
              initialRating: rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, index) => Icon(
                index < rating ? Icons.star : Icons.star_border, // star outline
                color: Colors.amber, // gold
              ),
              onRatingUpdate: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
            ),
            const SizedBox(height: 15),

            TextField(
              controller: reviewController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: "Write a review",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text("Cancel", style: TextStyle(color: Colors.black)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    print("User Rating: $rating");
                    print("Review: ${reviewController.text}");
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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

// not sure about this might change
void showRatingPopup(BuildContext context, String userName, String userImage) {
  showDialog(
    context: context,
    builder: (context) => RatingPopup(userName: userName, userImage: userImage),
  );
}

class Now extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userName = "John Doe"; // example username
    String userImage = "https://via.placeholder.com/150"; // example image URL

    return Scaffold(
      appBar: AppBar(title: Text('Now')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showRatingPopup(context, userName, userImage);
          },
          child: Text('Rate User'),
        ),
      ),
    );
  }
}